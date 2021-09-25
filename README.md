Thinpad 模板工程
---------------

工程包含示例代码和所有引脚约束，可以直接编译。

代码中包含中文注释，编码为utf-8，在Windows版Vivado下可能出现乱码问题。  
请用别的代码编辑器打开文件，并将编码改为GBK。

### 关于此 SpinalHDL 翻译

Scala / SpinalHDL 代码见 src/main/scala/riscv/。

为了编译运行和编辑代码，你需要
- JDK 8 或 11
- SBT（Scala Build Tool），链接见下
- IntelliJ IDEA 的 Scala 插件，或 VSCode 的 Scala (Metals) 插件

顶层模块为 ThinpadTop.scala 中的 `ThinpadTop`，里面包含示例代码。你可以在其基础上加入自己的代码，或修改已有的示例代码。在 IDEA 和 VSCode 中，或是在命令行中启动 SBT，可以运行 Main.scala 中的 `Main` 类，它会编译 SpinalHDL 编写的硬件，在 thinpad_top.srcs/sources_1/new/ 下生成 `ThinpadTop.sv`。生成的 `ThinpadTop.sv` 已被包含在 Vivado 工程中。和 Verilog 版本的框架一样，用 Vivado 打开根目录下的 `thinpad_top.xpr`，然后就可以综合、实现、生成 BitStream 等。

此翻译目前只包括示例代码，能够通过 GitLab CI，可以在 Thinpad CLOUD 上运行，可以观察到显示、数码管和串口正常运行。测例尚未翻译，不过可以在 src/test/scala 下加入自己的用 SpinalHDL 编写的测例。

有关链接：
- [安装 Scala 和 SBT](https://www.scala-lang.org/download/scala2.html)
- [Tour of Scala](https://docs.scala-lang.org/tour/tour-of-scala.html)
- [SpinalHDL 的文档](https://spinalhdl.github.io/SpinalDoc-RTD/master/index.html)

一些注意事项：
- 在 build.sbt 中，Scala 版本被设为 2.13.1，请不要随意升高 Scala 版本，否则可能会出现依赖问题。
