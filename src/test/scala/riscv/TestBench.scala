package riscv

import spinal.core._
import spinal.core.sim._

import scala.util.Random

object TestBench {
  def main(args: Array[String]): Unit = {
    SimConfig.withWave
      .withConfig(
        SpinalConfig(
          device = Device.XILINX,
          removePruned = true
        ).includeSimulation // 设置 GenerationFlags.simulation，方便黑盒判断是否在仿真中
      )
      .compile(new ThinpadTop) // 有意不添加 InOutWrapper，方便观察
      .doSimUntilVoid { dut =>
        dut.io.resetBtn #= true

        // 生成时钟线程
        // 为避免抢占 resetBtn，这里都分别构造了新的 ClockDomain
        // 注意时间单位是离散的。此程序以 1ps 为单位。例如 50 MHz 的时钟，周期为 20000 ps。
        ClockDomain(dut.io.clk50M).forkStimulus(1_000_000 / 50)
        ClockDomain(dut.io.clk11M0592).forkStimulus(1_000_000 / 110592)
        // 如果不同时钟（包括下方手动时钟）之间周期数量级差距过大，仿真效率会受影响，可以考虑注释掉不用的时钟相关代码

        // PLL 的输出时钟仿真
        val pllClockGen = dut.mainClockingArea.clockGen
        for (
          (freq, clk) <-
            pllClockGen.outputFrequencies zip pllClockGen.sim.clkOut
        ) {
          ClockDomain(clk).forkStimulus(1_000_000_000_000L / freq.toLong)
        }

        sleep(1_000_000) // 1 ms
        dut.io.resetBtn #= false

        // 在这里可以自定义测试输入序列，例如：
        fork { // 生成一个新线程（非必要，仅演示用）
          dut.io.touchBtn #= 0
          for (i <- 0 until 100) {
            println(s"cycle $i")
            sleep(100_000) // 100 ns
            dut.io.clockBtn #= true // 按下手工时钟按钮
            dut.io.touchBtn #= (i % 16) // 设置其他按钮

            sleep(200_000) // 200 ns
            dut.io.clockBtn #= false // 松开手工始终按钮
          }
          // 也可以用 ClockDomain 的方法来控制时钟按钮

          simSuccess() // 结束仿真并返回成功。注意任何一个线程 simSuccess 都会立刻结束仿真。
          // simFailure()
        }

        // 另一个使用已 forkStimulus 的时钟的例子。
        // 手动控制时钟的机会较少，每个时钟周期自动做事的机会较多。
        fork {
          for (i <- 0 until 100) {
            // 等待主时钟域（clk50M）采样，即未 reset 的上升沿
            dut.mainClockDomain.waitSampling()
            // 随机设置拨码开关
            dut.io.dipSw #= Random.nextLong(1L << 32)
          }
        }

        fork {
          // TODO: CPLD UART
        }

        fork {
          // TODO: Base RAM
        }

        fork {
          // TODO: Ext RAM
        }

      // 不打算尝试仿真 Flash 等，反正如果你要用，你应该已经会仿真了。
      // 原框架提供的 Flash 模型**有可能**有不可综合的代码而不适合 Verilator 运行。
      }
  }
}
