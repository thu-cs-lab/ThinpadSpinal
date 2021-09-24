package riscv

import spinal.core._
import spinal.lib._
import spinal.lib.com.uart.{Uart, UartCtrl, UartCtrlInitConfig, UartParityType, UartStopType}
import spinal.lib.graphic.vga.Vga

import scala.language.postfixOps

class ThinpadTop extends Component {
  import thinpad._

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

    /** CPLD串口控制器信号 */
    val uartControlled = master(UartCpldInterface())

    val baseRam = master(SramInterface())
    val extRam  = master(SramInterface())

    /** 直连串口信号 */
    val uartRaw = master(Uart())

    val flash = master(Flash())

    /** USB 控制器信号，参考 SL811 芯片手册 */
    val sl811 = master(SL811Interface())

    /** 网络控制器信号，参考 DM9000A 芯片手册 */
    val dm9k = master(DM9kInterface())

    /** 图像输出信号 */
    val video = master(Vga(vgaConfig))

    /** 像素时钟输出 */
    val videoClk = out Bool ()
  }

  noIoPrefix()

  /* =========== Demo code begin =========== */

  /** 主时钟域 */
  val mainClockDomain = ClockDomain(io.clk50M, io.resetBtn)

  /** 由时钟按钮构成的时钟域 */
  val btnClockDomain = ClockDomain(io.clockBtn, io.resetBtn)

  val mainClockingArea = new ClockingArea(mainClockDomain) {

    // PLL 分频示例
    val clockGen = new ip.PllExample()
    val clkOut0Area = new ClockingArea(clockGen.outputClockDomain(0)) {
      // Your Code
    }

    // 不使用内存、串口时，禁用其使能信号
    io.baseRam.ceN := True
    io.baseRam.oeN := True
    io.baseRam.weN := True
    io.extRam.ceN  := True
    io.extRam.oeN  := True
    io.extRam.weN  := True
    io.uartControlled.rdn    := True
    io.uartControlled.wrn    := True

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
        stop = UartStopType.TWO
      )
    )
    io.uartRaw <> uartRawCtrl.io.uart

    // 将读取到的数据转发到 UART 写端，中间加一级缓冲并隔断组合通路
    uartRawCtrl.io.read >/-> uartRawCtrl.io.write
    // 并存入 number
    number := uartRawCtrl.io.write.payload

    // 图像输出演示，分辨率800x600@75Hz，像素时钟为50MHz
    val vga800x600at75 = new VgaExample()
    val hData          = vga800x600at75.io.hData

    io.video.color.r := (hData < 266) ? B"111" | B"3'b0"                 // 红色竖条
    io.video.color.g := (hData < 532 && hData >= 266) ? B"111" | B"3'b0" // 绿色竖条
    io.video.color.b := (hData >= 532) ? B"11" | B"2'b0"                 // 蓝色竖条

    io.video.colorEn := vga800x600at75.io.colorEn

    io.videoClk := ClockDomain.current.readClockWire

  }.setName("") // 避免生成 verilog 中信号名有额外前缀

  /* =========== Demo code end =========== */
}
