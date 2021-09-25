package riscv

import spinal.core._
import spinal.lib._
import spinal.lib.graphic.RgbConfig
import spinal.lib.io.TriStateArray

import scala.language.postfixOps

package object thinpad {
  val vgaConfig = RgbConfig(rWidth = 3, gWidth = 3, bWidth = 2)

  // 由于 ThinpadTop 顶层某些接口间共用数据信号，所以对应的 Bundle 用继承的手段，
  // 实现了带数据信号和不带数据信号的两个版本。

  /** 分享数据信号用的模块。将 io.shared 依照 sharedRanges 指定的范围分享给 io.ranges */
  class DataWireSharer(width: BitCount, sharedRanges: Seq[Range])
      extends Component {
    val io = new Bundle {
      val shared = master(TriStateArray(width))
      val ranges = sharedRanges map { r => slave(TriStateArray(r.length bits)) }
    }

    // shared 默认不写。
    io.shared.writeEnable := 0
    io.shared.write.assignDontCare()

    // 各 io.ranges 的读来源于 io.shared 的对应段
    for (i <- sharedRanges.indices) {
      io.ranges(i).read := io.shared.read(sharedRanges(i))
    }

    for (i <- 0 until width.value) {
      // 包含第 i bit 的 range
      val relatedRanges = (io.ranges zip sharedRanges).filter(_._2 contains i)

      // 要求同时至多有一个在写第 i 位
      assert(
        CountOne(relatedRanges.map(_._1.writeEnable(i))) <= 1,
        "At most one shared data wire is allowed to be written simultaneously"
      )

      // 逐个遍历有关的 range，如果某一个在写，则 shared 该位在写，且要写的值是这个 range 要写的值
      for ((tsa, range) <- relatedRanges) {
        when(tsa.writeEnable(i - range.start)) {
          io.shared.writeEnable(i) := True
          io.shared.write(i)       := tsa.write(i - range.start)
        }
      }
    }
  }

  /** 包含数据信号的 trait */
  trait WithDataWire extends Bundle with IMasterSlave {

    /** 数据信号宽度，由子类提供 */
    def dataWidth: BitCount

    /** 数据信号。
      *
      * Z 应避免在 FPGA 内部出现，[[TriStateArray]] 用不使用 Z 的方式表示 [[dataWidth]] 宽度的三态线路。
      */
    val data = TriStateArray(dataWidth)

    abstract override def asMaster() = {
      super.asMaster()
      master(data)
    }
  }

  /** CPLD 串口控制器信号基类 */
  trait UartControllerInterfaceBase extends Bundle with IMasterSlave {

    /** 读串口信号，低有效 */
    val rdn = Bool

    /** 写串口信号，低有效 */
    val wrn = Bool

    /** 串口数据准备好 */
    val dataReady = Bool

    /** 发送数据标志 */
    val tbre = Bool

    /** 数据发送完毕标志 */
    val tsre = Bool

    override def asMaster() = {
      out(rdn, wrn)
      in(dataReady, tbre, tsre)
    }
  }

  /** CPLD 串口控制器信号，不包括 data */
  case class UartControllerInterfaceWithoutData()
      extends UartControllerInterfaceBase {

    def withData(data: TriStateArray): UartControllerInterface = new Composite(
      this
    ) {
      val withData = UartControllerInterface()

      rdn                := withData.rdn
      wrn                := withData.wrn
      withData.dataReady := dataReady
      withData.tbre      := tbre
      withData.tsre      := tsre

      withData.data.read := data.read
      data.write         := withData.data.write
      data.writeEnable   := withData.data.writeEnable
    }.withData
  }

  /** CPLD 串口控制器信号 */
  case class UartControllerInterface()
      extends UartControllerInterfaceBase
      with WithDataWire {
    override def dataWidth = 8 bits
  }

  /** SRAM 信号基类 */
  trait SramInterfaceBase extends Bundle with IMasterSlave {

    /** 地址 */
    val addr = UInt(20 bits)

    /** 字节使能，低有效。如果不使用字节使能，请保持为 0 */
    val beN = Bits(4 bits)

    /** 片选，低有效 */
    val ceN = Bool

    /** 读使能，低有效 */
    val oeN = Bool

    /** 写使能，低有效 */
    val weN = Bool

    override def asMaster() = {
      out(addr, beN, ceN, oeN, weN)
    }
  }

  /** SRAM 信号，不包括 data */
  case class SramInterfaceWithoutData() extends SramInterfaceBase {
    def withData(data: TriStateArray): SramInterface = new Composite(this) {
      val withData = SramInterface()

      addr := withData.addr
      beN  := withData.beN
      ceN  := withData.ceN
      oeN  := withData.oeN
      weN  := withData.weN

      withData.data.read := data.read
      data.write         := withData.data.write
      data.writeEnable   := withData.data.writeEnable
    }.withData
  }

  /** SRAM 信号 */
  case class SramInterface() extends SramInterfaceBase with WithDataWire {
    override def dataWidth = 32 bits
  }

  /** Flash存储器信号，参考 JS28F640 芯片手册 */
  case class Flash() extends Bundle with IMasterSlave {

    /** 地址，a0 仅在 8bit 模式有效，16bit 模式无意义 */
    val a = UInt(23 bits)

    /** 数据，[[TriStateArray]] 表示 [[inout]] */
    val d = TriStateArray(16 bits)

    /** Flash 复位信号，低有效 */
    val rpN = Bool

    /** 写保护信号，低电平时不能擦除、烧写 */
    val vpen = Bool

    /** 片选信号，低有效 */
    val ceN = Bool

    /** 读使能信号，低有效 */
    val oeN = Bool

    /** 写使能信号，低有效 */
    val weN = Bool

    /** 8bit模式选择，低有效。在使用 flash 的 16bit 模式时请设为 1 */
    val byteN = Bool

    override def asMaster() = {
      out(a, rpN, vpen, ceN, oeN, weN, byteN)
      master(d)
    }
  }

  /** USB 控制器信号基类 */
  trait SL811InterfaceBase extends Bundle with IMasterSlave {
    val a0 = Bool

    val wrN  = Bool
    val rdN  = Bool
    val csN  = Bool
    val rstN = Bool

    val dAckN = Bool
    val dRqN  = Bool

    val intRq = Bool

    override def asMaster() = {
      out(a0, wrN, rdN, csN, rstN, dAckN)
      in(dRqN, intRq)
    }
  }

  /** USB 控制器信号，不包括 data */
  case class SL811InterfaceWithoutData() extends SL811InterfaceBase {
    def withData(data: TriStateArray): SL811Interface = new Composite(this) {
      val withData = SL811Interface()

      a0             := withData.a0
      wrN            := withData.wrN
      rdN            := withData.rdN
      csN            := withData.csN
      rstN           := withData.rstN
      dAckN          := withData.dAckN
      withData.dRqN  := dRqN
      withData.intRq := intRq

      withData.data.read := data.read
      data.write         := withData.data.write
      data.writeEnable   := withData.data.writeEnable
    }.withData
  }

  /** USB 控制器信号，参考 SL811 芯片手册 */
  case class SL811Interface() extends SL811InterfaceBase with WithDataWire {
    override def dataWidth = 8 bits
  }

  /** 网络控制器信号，参考 DM9000A 芯片手册 */
  trait DM9kInterfaceBase extends Bundle with IMasterSlave {
    val cmd = Bool

    val iowN   = Bool
    val iorN   = Bool
    val csN    = Bool
    val pwrstN = Bool
    val int    = Bool

    override def asMaster() = {
      out(cmd, iowN, iorN, csN, pwrstN)
      in(int)
    }
  }

  /** 网络控制器信号，不包括 data */
  case class DM9kInterfaceWithoutData() extends DM9kInterfaceBase {
    def withData(data: TriStateArray): DM9kInterface = new Composite(this) {
      val withData = DM9kInterface()

      cmd          := withData.cmd
      iowN         := withData.iowN
      iorN         := withData.iorN
      csN          := withData.csN
      pwrstN       := withData.pwrstN
      withData.int := int

      withData.data.read := data.read
      data.write         := withData.data.write
      data.writeEnable   := withData.data.writeEnable
    }.withData
  }

  /** 网络控制器信号，参考 DM9000A 芯片手册 */
  case class DM9kInterface() extends DM9kInterfaceBase with WithDataWire {
    override def dataWidth = 16 bits
  }
}
