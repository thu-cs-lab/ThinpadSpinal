package riscv

import spinal.core._
import spinal.core.sim._

/** 对仿真有帮助的工具 */
package object simUtils {

  /** 在顶层模块的输入中增加一条线，将其拉进当前模块，赋值给 data 参数。这样，data 的值会由外部给定。
    *
    * 这样做是为了在仿真时用软件模拟 IP，如 PLL 等。SpinalHDL 的仿真默认后端是 Verilator。Verilator
    * 只在顶层模块的输入改变时，才重新计算模块内部各信号的值。如果直接用 #= 驱动 IP
    * 的输出，依赖此输出的其他值不会更新。尤其是组合信号可能只会到下个周期才更新。
    *
    * 因此需要从顶层拉一根新线进来，仿真时改驱动拉进来的顶层模块的输入。
    *
    * @param data
    *   要在仿真中被软件驱动的内部信号，如 PLL 的时钟输出。如此函数中间所示，它会被赋值为拉进来的信号。
    * @return
    *   新增的顶层模块的输入。仿真时软件驱动它，即可有效地驱动 data。
    */
  def pullFromOutside[T <: Data](data: T): T = {
    // 在所有 Component 之外建立该输入，并 pull 到 data 所在位置。
    Component.push(null)
    val external = cloneOf(data).setWeakName(data.getName()).simPublic()
    Component.pop(null)

    data := Data.doPull(external, Component.current, useCache = true)

    // 顶层模块中得到的值为整个顶层模块的输入，仿真时应驱动此输入
    GlobalData.get.toplevel.pulledDataCache(external).asInstanceOf[T]
  }

}
