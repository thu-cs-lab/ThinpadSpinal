package riscv

import spinal.core._

import scala.language.postfixOps

/** @param width:
  *   bits in register hdata & vdata
  * @param hSize:
  *   horizontal size of visible field
  * @param hFp:
  *   horizontal front of pulse
  * @param hSp:
  *   horizontal stop of pulse
  * @param hMax:
  *   horizontal max size of value
  * @param vSize:
  *   vertical size of visible field
  * @param vFp:
  *   vertical front of pulse
  * @param vSp:
  *   vertical stop of pulse
  * @param vMax:
  *   vertical max size of value
  * @param hSpp:
  *   horizontal synchro pulse polarity
  * @param vSpp:
  *   vertical synchro pulse polarity
  */
class VgaExample(
    width: Int = 0,
    hSize: Int = 0,
    hFp: Int = 0,
    hSp: Int = 0,
    hMax: Int = 0,
    vSize: Int = 0,
    vFp: Int = 0,
    vSp: Int = 0,
    vMax: Int = 0,
    hSpp: Polarity = LOW,
    vSpp: Polarity = LOW
) extends Component {
  val io = new Bundle {
    val hSync   = out Bool ()
    val vSync   = out Bool ()
    val hData   = out(Reg(UInt(width bits)))
    val vData   = out(Reg(UInt(width bits)))
    val colorEn = out Bool ()
  }

  when(io.hData === hMax - 1) {
    io.hData := 0
    when(io.vData === vMax - 1) {
      io.vData := 0
    } otherwise {
      io.vData := io.vData + 1
    }
  } otherwise {
    io.hData := io.hData + 1
  }

  val hSppBool = Bool(hSpp == HIGH)
  io.hSync := (io.hData >= hFp && io.hData < hSp) ? hSppBool | !hSppBool

  val vSppBool = Bool(vSpp == HIGH)
  io.vSync := (io.vData >= vFp && io.vData < vSp) ? vSppBool | !vSppBool

  io.colorEn := io.hData < hSize && io.vData < vSize
}
