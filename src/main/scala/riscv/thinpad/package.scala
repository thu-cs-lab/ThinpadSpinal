package riscv

import spinal.core._
import spinal.lib._
import spinal.lib.graphic.RgbConfig
import spinal.lib.io.TriStateArray

import scala.language.postfixOps

package object thinpad {
  val vgaConfig = RgbConfig(rWidth = 3, gWidth = 3, bWidth = 2)

  /** CPLD串口控制器信号 */
  case class UartCpldInterface() extends Bundle with IMasterSlave {

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

  /** SRAM 信号 */
  case class SramInterface() extends Bundle with IMasterSlave {

    /** 数据，[[TriStateArray]] 表示 [[inout]]，在 ThinpadTop 中与 CPLD 串口控制器共享低 8 位 */
    val data = TriStateArray(32 bits)

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
      master(data)
    }
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

  /** USB 控制器信号，参考 SL811 芯片手册 */
  case class SL811Interface() extends Bundle with IMasterSlave {
    val a0 = Bool

    /** [[TriStateArray]] 表示 [[inout]]，在 ThinpadTop 中与 [[DM9kInterface#sd]] 共享低 8 位 */
    val d     = TriStateArray(8 bits)
    val wrN   = Bool
    val rdN   = Bool
    val csN   = Bool
    val rstN  = Bool
    val dAckN = Bool
    val dRqN  = Bool
    val intRq = Bool

    override def asMaster() = {
      out(a0, wrN, rdN, csN, rstN, dAckN)
      master(d)
      in(dRqN, intRq)
    }
  }

  /** 网络控制器信号，参考 DM9000A 芯片手册 */
  case class DM9kInterface() extends Bundle with IMasterSlave {
    val cmd = Bool

    /** [[TriStateArray]] 表示 [[inout]]，在 ThinpadTop 中与 [[SL811Interface#d]] 共享低 8 位 */
    val sd     = TriStateArray(16 bits)
    val iowN   = Bool
    val iorN   = Bool
    val csN    = Bool
    val pwrstN = Bool
    val int    = Bool

    override def asMaster() = {
      out(cmd, iowN, iorN, csN, pwrstN)
      master(sd)
      in(int)
    }
  }
}
