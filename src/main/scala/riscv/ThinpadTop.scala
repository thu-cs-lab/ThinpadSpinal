package riscv

import riscv.thinpad._
import spinal.core._
import spinal.lib._
import spinal.lib.com.uart._
import spinal.lib.graphic.vga.Vga
import spinal.lib.io.{InOutWrapper, TriStateArray}

import scala.language.postfixOps

class ThinpadTop extends Component {

  val io = new Bundle {

    /** 50MHz 时钟输入 */
    val clk50M = in Bool ()

    /** 11.0592MHz 时钟输入（备用，可不用） */
    val clk11M0592 = in Bool ()

    /** BTN5 手动时钟按钮开关，带消抖电路，按下时为 1 */
    val clockBtn = in Bool ()

    /** BTN6 手动复位按钮开关，带消抖电路，按下时为 1 */
    val resetBtn = in Bool ()

    /** BTN1~BTN4，按钮开关，按下时为 1 */
    val touchBtn = in Bits (4 bits)

    /** 32位拨码开关，拨到 “ON” 时为 1 */
    val dipSw = in Bits (32 bits)

    /** 16 位 LED，输出时 1 点亮 */
    val leds = out Bits (16 bits)

    /** 数码管低位信号，包括小数点，输出 1 点亮 */
    val dpy0 = out Bits (8 bits)

    /** 数码管高位信号，包括小数点，输出 1 点亮 */
    val dpy1 = out Bits (8 bits)

    /** CPLD串口控制器信号，去除数据信号，数据信号与 [[baseRam]] 数据信号低 8 位共享。
      *
      * 不应直接使用此信号，使用下面分配了数据信号的版本即可。
      */
    val uartControlled = master(UartControllerInterfaceWithoutData())

    /** BaseRAM 信号，去除数据信号，数据信号低 8 位与 [[uartControlled]] 共享。
      *
      * 不应直接使用此信号，使用下面分配了数据信号的版本即可。
      */
    val baseRam = master(SramInterfaceWithoutData())

    /** CPLD 串口控制器和 baseRam 共享的数据信号。
      *
      * Z 应避免在 FPGA 内部出现，[[TriStateArray]] 用不使用 Z 的方式表示三态线路，在生成顶层原件时用
      * [[InOutWrapper]] 将其转换为带 Z 的 inout 线路。
      */
    val uartAndBaseRamData = master(TriStateArray(32 bits))

    /** ExtRAM 信号，包括数据信号 */
    val extRam = master(SramInterface())

    /** 直连串口信号 */
    val uartRaw = master(Uart())

    /** Flash存储器信号，参考 JS28F640 芯片手册 */
    val flash = master(Flash())

    /** USB 控制器信号，去除数据信号，数据信号与 [[dm9k]] 数据信号低 8 位共享，参考 SL811 芯片手册。
      *
      * 不应直接使用此信号，使用下面分配了数据信号的版本即可。
      */
    val sl811 = master(SL811InterfaceWithoutData())

    /** 网络控制器信号，去除数据信号，数据信号低 8 位与 [[sl811]] 共享，参考 DM9000A 芯片手册。
      *
      * 不应直接使用此信号，使用下面分配了数据信号的版本即可。
      */
    val dm9k = master(DM9kInterfaceWithoutData())

    /** USB 控制器和网络控制器共享的数据信号 */
    val usbAndNetworkData = master(TriStateArray(16 bits))

    /** 图像输出信号 */
    val video = master(Vga(vgaConfig))

    /** 像素时钟输出 */
    val videoClk = out Bool ()
  }

  noIoPrefix()

  /** 主时钟域 */
  val mainClockDomain = ClockDomain(
    clock = io.clk50M,
    reset = io.resetBtn,
    frequency = FixedFrequency(50 MHz)
  )

  /** 由时钟按钮构成的时钟域 */
  val btnClockDomain = ClockDomain(io.clockBtn, io.resetBtn)

  val mainClockingArea = new ClockingArea(mainClockDomain) {

    /* =========== Demo code begin =========== */

    // PLL 分频示例
    val clockGen = new ip.PllExample()
    val clkOut0Area = new ClockingArea(clockGen.outputClockDomain(0)) {
      // Your Code
    }

    // 不使用内存、串口时，禁用其使能信号

    io.uartControlled.rdn              := True
    io.uartControlled.wrn              := True

    io.baseRam.ceN := True
    io.baseRam.oeN := True
    io.baseRam.weN := True
    io.baseRam.beN := 0
    io.baseRam.addr.assignDontCare()

    io.uartAndBaseRamData.writeEnable := 0
    io.uartAndBaseRamData.write.assignDontCare()

    io.extRam.ceN := True
    io.extRam.oeN := True
    io.extRam.weN := True
    io.extRam.beN := 0
    io.extRam.addr.assignDontCare()
    io.extRam.data.writeEnable := 0
    io.extRam.data.write.assignDontCare()

    // 其余课程不必须的信号暂时赋 X（assignDontCare）。
    // 如果需要，可以将对应信号从这里去除。
    for (
      undriven <- Seq(io.flash, io.sl811, io.dm9k, io.usbAndNetworkData);
      signal   <- undriven.flatten if !signal.isInput
    ) {
      signal.assignDontCare()
    }

    // 数码管连接关系示意图，dpy1同理
    // p=dpy0(0) // ---a---
    // c=dpy0(1) // |     |
    // d=dpy0(2) // f     b
    // e=dpy0(3) // |     |
    // b=dpy0(4) // ---g---
    // a=dpy0(5) // |     |
    // f=dpy0(6) // e     c
    // g=dpy0(7) // |     |
    //           // ---d---  p

    // 7段数码管译码器演示，将number用16进制显示在数码管上面
    val number = Bits(8 bits)
    // 以函数语法将 number 转换为 seg，详见 Seg7Lut
    io.dpy0 := Seg7Lut(number(0 until 4))
    io.dpy1 := Seg7Lut(number(4 until 8))

    val btnClockingArea = new ClockingArea(btnClockDomain) {
      val ledBits = Reg(Bits(16 bits)) init 1 // 复位按下，设置LED为初始值
      ledBits := ledBits.rotateLeft(1) // 每次按下时钟按钮，LED循环左移
      io.leds := ledBits
    }

    // 直连串口接收发送演示，从直连串口收到的数据再发送出去
    // 建立 UART 控制器
    val uartRawCtrl = UartCtrl(
      UartCtrlInitConfig(
        baudrate = 9600,
        dataLength = 7, // 8 bits
        parity = UartParityType.NONE,
        stop = UartStopType.ONE
      )
    )
    io.uartRaw <> uartRawCtrl.io.uart

    // 将读取到的数据转发到 UART 写端，中间加一级寄存器缓冲并隔断组合通路
    uartRawCtrl.io.read >/-> uartRawCtrl.io.write
    // 并存入 number
    number := uartRawCtrl.io.write.payload

    // 图像输出演示，分辨率800x600@75Hz，像素时钟为50MHz
    val vga800x600at75 = new VgaExample(
      width = 12,
      hSize = 800,
      hFp = 856,
      hSp = 976,
      hMax = 1040,
      vSize = 600,
      vFp = 637,
      vSp = 643,
      vMax = 666,
      hSpp = HIGH,
      vSpp = HIGH
    )
    val hData = vga800x600at75.io.hData

    io.video.color.r := (hData < 266) ? U(7) | U(0)                 // 红色竖条
    io.video.color.g := (hData < 532 && hData >= 266) ? U(7) | U(0) // 绿色竖条
    io.video.color.b := (hData >= 532) ? U(3) | U(0)                // 蓝色竖条

    io.video.colorEn := vga800x600at75.io.colorEn

    io.video.hSync := vga800x600at75.io.hSync
    io.video.vSync := vga800x600at75.io.vSync

    io.videoClk := ClockDomain.current.readClockWire

    /* =========== Demo code end =========== */

  }.setName("") // 避免生成 verilog 中信号名有额外前缀
}
