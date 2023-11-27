import chisel3._
import chisel3.util._

class Accelerator extends Module {
  val io = IO(new Bundle {
    val start = Input(Bool())
    val done = Output(Bool())

    val address = Output(UInt (16.W))
    val dataRead = Input(UInt (32.W))
    val writeEnable = Output(Bool ())
    val dataWrite = Output(UInt (32.W))

  })

  // go through states for each step
  val idle :: center :: top :: left :: right :: bottom :: read :: check:: write :: done :: Nil = Enum (10)
  val stateReg = RegInit(idle) // center, top, left, right, bottom
  val stepReg = RegInit(idle) // all

  // center/top/left/right/bottom -> read -> check -> repeat | write -> repeat | done

  val addressReg = RegInit(0.U(16.W))
  val dataReg = RegInit(0.U(32.W))

  val cxReg = RegInit(0.S(32.W))
  val cyReg = RegInit(0.S(32.W))
  val xReg = RegInit(0.S(32.W))
  val yReg = RegInit(0.S(32.W))

  io.writeEnable := false.B
  io.address := 0.U(16.W)
  io.dataWrite := dataReg
  io.done := false.B

  switch (stepReg)
  {
    is (idle)
    {
      when (io.start)
      {
        stepReg := center
        addressReg := 0.U(32.W)
        xReg := 0.S(32.W)
        yReg := 0.S(32.W)
      }
    }
    // ------
    is (read)
    {
      when (xReg >= 0.S(32.W) && xReg < 20.S(32.W) && yReg >= 0.S(32.W) && yReg < 20.S(32.W)) {
        io.address := yReg * 20.S(32.W) + xReg
        dataReg := io.dataRead
      } .otherwise {
        dataReg := 0.U(32.W)
      }

      stepReg := check
    }
    is (check)
    {
      when (dataReg === 0.U(32.W)) {
        stepReg := write
      } .otherwise {
        stepReg := stateReg
      }
    }
    is (write)
    {
      io.address := addressReg + 400.U(16.W)
      io.writeEnable := true.B

      when (cxReg === 19.S(32.W)) {
        cyReg := cyReg + 1.S(32.W)
        cxReg := 0.S(32.W)
      } .otherwise {
        cxReg := cxReg + 1.S(32.W)
      }

      when (addressReg === 399.U(16.W)) {
        stepReg := done
      } .otherwise {
        addressReg := addressReg + 1.U(16.W)
        stepReg := center
      }
    }
    // -----------
    is (center)
    {
      xReg := cxReg
      yReg := cyReg

      stepReg := read
      stateReg := top
    }
    is (top)
    {
      xReg := cxReg
      yReg := cyReg - 1.S(32.W)

      stepReg := read
      stateReg := left
    }
    is (left)
    {
      xReg := cxReg - 1.S(32.W)
      yReg := cyReg

      stepReg := read
      stateReg := right
    }
    is (right)
    {
      xReg := cxReg + 1.S(32.W)
      yReg := cyReg

      stepReg := read
      stateReg := bottom
    }
    is (bottom)
    {
      xReg := cxReg
      yReg := cyReg + 1.S(32.W)

      stepReg := read
      stateReg := write
    }

    // ----------
    is (done)
    {
      io.done := true.B
      stepReg := done
    }
  }

  //Write here your code

}
