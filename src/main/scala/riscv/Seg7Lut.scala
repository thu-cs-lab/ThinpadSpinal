package riscv

import spinal.core._

import scala.language.postfixOps

class Seg7Lut extends Component {
  val io = new Bundle {
    val iDig = in Bits (4 bits)
    val oSeg = out Bits (8 bits)
  }

  val oSegReg = RegNext(
    io.iDig mux (
      1  -> B"7'b1110110",
      2  -> B"7'b0100001",
      3  -> B"7'b0100100",
      4  -> B"7'b0010110",
      5  -> B"7'b0001100",
      6  -> B"7'b0001000",
      7  -> B"7'b1100110",
      8  -> B"7'b0000000",
      9  -> B"7'b0000110",
      10 -> B"7'b0000010",
      11 -> B"7'b0011000",
      12 -> B"7'b1001001",
      13 -> B"7'b0110000",
      14 -> B"7'b0001001",
      15 -> B"7'b0001011",
      0  -> B"7'b1000000"
    )
  )

  io.oSeg := ~oSegReg ## False
}

object Seg7Lut {

  /** 将组合电路 Seg7Lut 表示成一个函数 */
  def apply(iDig: Bits): Bits = new Composite(iDig) {
    // Composite 是一个 Area，
    // 用于在 verilog 中将下面的信号和模块命名为 <iDig 的名字>_<信号/模块名> 的形式。

    val seg7lut = new Seg7Lut()
    seg7lut.io.iDig := iDig
    val oSeg = seg7lut.io.oSeg
  }.oSeg
}
