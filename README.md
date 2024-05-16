# 基于SpinalHDL的 Thinpad 模板工程

## 说明

> *240401 Update* 升级至 Scala 2.13.12、更新至 SpinalHDL 1.10.1、支持 `mill` 编译

使用前请阅读[Thinpad项目](https://lab.cs.tsinghua.edu.cn/cod-lab-docs/labs/lab2/thinpad_top/)的组织方式、熟悉[Vivado使用](https://lab.cs.tsinghua.edu.cn/cod-lab-docs/labs/lab2/vivado/)，对 [SpinalHDL](https://spinalhdl.github.io/SpinalDoc-RTD/master/index.html) 有初步了解

顶层模块为 ThinpadTop.scala 中的 `ThinpadTop`，里面包含示例代码。你可以在其基础上加入自己的代码，或修改已有的示例代码。

在 IDEA 和 VSCode 中，或是在命令行中启动 `sbt` 或 `mill`，可以运行 `src/main/Main.scala` 中的 `Main` 类，它会编译 SpinalHDL 编写的硬件设计，生成 `thinpad_top.srcs/sources_1/new/ThinpadTop.sv`

生成的 `ThinpadTop.sv` 已被包含在 Vivado 工程中。和 Verilog 版本的框架一样，用 Vivado 打开根目录下的 `thinpad_top.xpr`，然后就可以综合、实现、生成 BitStream 等。

此翻译目前只包括示例代码，能够通过 GitLab CI，可以在 Thinpad CLOUD 上运行，可以观察到显示、数码管和串口正常运行。测例尚未翻译，不过可以在 `src/test/scala/riscv` 下加入自己的用 SpinalHDL 编写的测例。

## 安装

你需要在 Linux环境（包括 WSL2）下安装：

- `openjdk-17`
- `sbt` 或 `mill`
    - [`sbt` 安装](https://www.scala-sbt.org/download)
    - [`mill` 安装](https://mill-build.com/mill/Installation_IDE_Support.html) | [`millw`安装](https://github.com/lefou/millw)
- IntelliJ IDEA 的 Scala 插件，或 VSCode 的 Metals 插件

> *240515 Update* Metals 1.3.x 起不再支持使用`openjdk-11`（或`default-jdk`），如果需要请指定使用 Metals 1.2.2

参考配置如下：

- OS：Windows 10/11 + WSL2 Ubuntu jammy
- 工具链：`default-jdk`, `millw-0.4.11` (latest)
- 开发环境：VSCode Metals 插件 v1.30.0、Metals Server 1.2.2（在插件设置中指定 <kbd> Metals: Server Version</kbd>为`1.2.2`）
- 仿真工具：Iverilog + GTKWave

## 开发人员

本项目由 [TRCYX](https://github.com/TRCYX) 于 2021年9月 创建，目前由 [yuxuan-z19](https://github.com/yuxuan-z19) 维护