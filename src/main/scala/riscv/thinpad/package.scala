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
      extends UartControllerInterfaceBase

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
  case class SramInterfaceWithoutData() extends SramInterfaceBase

  /** SRAM 信号 */
  case class SramInterface() extends SramInterfaceBase with WithDataWire {
    override def dataWidth = 32 bits
  }

  /** Flash 存储器信号，参考 JS28F640 芯片手册 */
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

    /** 8bit 模式选择，低有效。在使用 flash 的 16bit 模式时请设为 1 */
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
  case class SL811InterfaceWithoutData() extends SL811InterfaceBase

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
  case class DM9kInterfaceWithoutData() extends DM9kInterfaceBase

  /** 网络控制器信号，参考 DM9000A 芯片手册 */
  case class DM9kInterface() extends DM9kInterfaceBase with WithDataWire {
    override def dataWidth = 16 bits
  }
}
