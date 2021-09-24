package riscv.ip

import spinal.core._

/** 封装 pll_example IP 的黑盒
  * @param outputCount 输出的时钟数量，需和 IP 一致。
  */
class PllExample(outputCount: Int = 2) extends BlackBox {
  setDefinitionName("pll_example")

  val io = new Bundle {

    /** 外部时钟输入 */
    val clkIn = in Bool ()

    /** PLL复位输入 */
    val reset = in Bool ()

    /** 时钟输出，频率在IP配置界面中设置 */
    val clkOut = out Vec (Bool, 2)

    /** PLL锁定指示输出，"1"表示时钟稳定，后级电路复位信号应当由它生成 */
    val locked = out Bool ()
  }

  noIoPrefix()

  // 将 PllExample 实例所在时钟域的 clk 和 reset 映射到这两个 IO 信号，
  // 从而实例化时不需要手动指定这两个 IO 信号的连接。
  mapClockDomain(clock = io.clkIn, reset = io.reset)

  /** 获取第 index 个输出时钟域 */
  def outputClockDomain(index: Int): ClockDomain = {
    val tempCd = ClockDomain(
      clock = io.clkOut(index),
      reset = io.locked,
      config = ClockDomainConfig(resetActiveLevel = LOW)
    )

    val tempCdArea = new ClockingArea(tempCd) {
      // 异步复位、同步释放的后级电路的复位
      val newReset = Reg(Bool) init True
      newReset := False
    }

    ClockDomain(io.clkOut(index), tempCdArea.newReset)
  }
}
