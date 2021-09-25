package riscv

import spinal.core.{Device, SpinalConfig, SpinalSystemVerilog}
import spinal.lib.io.InOutWrapper

object Main {
  def main(args: Array[String]): Unit = {
    val config = SpinalConfig(
      targetDirectory = "./thinpad_top.srcs/sources_1/new",
      device = Device.XILINX,
      removePruned = true,
      noAssert = false
    )

    SpinalSystemVerilog(config)(InOutWrapper(new ThinpadTop))
  }
}
