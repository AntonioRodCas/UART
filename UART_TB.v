 /*********************************************************
 * Description:
 * This module is test bench file for testing the UART module
 *
 *
 *	Author:  Antonio Rodríguez    md193781   ITESO 
 *	Date:    25/10/18
 *
 **********************************************************/ 
 
 
 
module UART_TB;

parameter WORD_LENGTH = 8;


reg clk_tb = 0;
reg reset_tb;
reg SerialDataIn_tb = 0;
reg Clear_RX_Flag_tb = 0;

reg [WORD_LENGTH - 1 : 0] DATATX_tb;
reg Transmit_tb = 0;


wire [WORD_LENGTH-1 : 0] DATARX_tb;
wire RX_FLAG_tb;
wire SerialDataOut_tb;
wire ParityError_tb;


UART
#(
	.WORD_LENGTH(WORD_LENGTH)
)
UART1
(
	.clk(clk_tb),
	.reset(reset_tb),
	.SerialDataIn(SerialDataIn_tb),
	.Clear_RX_Flag(Clear_RX_Flag_tb),
	.DATATX(DATATX_tb),
	.Transmit(Transmit_tb),
	
	.DATARX(DATARX_tb),
	.RX_FLAG(RX_FLAG_tb),
	.SerialDataOut(SerialDataOut_tb),
	.ParityError(ParityError_tb)

);

/*********************************************************/
initial // Clock generator
  begin
    forever #2 clk_tb = !clk_tb;
  end
/*********************************************************/
initial begin // reset generator
   #0 reset_tb = 0;
   #5 reset_tb = 1;
end

/*********************************************************/
initial begin // DATATX 
	#5 DATATX_tb = 50;
end


/*********************************************************/
initial begin // Transmit
	#0 Transmit_tb = 0;
	#5 Transmit_tb = 1;
	#5 Transmit_tb = 0;
end


/*********************************************************/
initial begin // Serial Data IN
	#5 SerialDataIn_tb = 1;
	#15 SerialDataIn_tb= 0;
	#64 SerialDataIn_tb = 1;
	#64 SerialDataIn_tb = 0;
	#64 SerialDataIn_tb = 0;
	#64 SerialDataIn_tb = 1;
	#64 SerialDataIn_tb = 0;
	#64 SerialDataIn_tb = 1;
	#64 SerialDataIn_tb = 1;
	#64 SerialDataIn_tb = 0;
	#64 SerialDataIn_tb = 1; //Parity Bit
	#64 SerialDataIn_tb = 1;
	#120 SerialDataIn_tb= 0;
	#64 SerialDataIn_tb = 1;
	#64 SerialDataIn_tb = 0;
	#64 SerialDataIn_tb = 0;
	#64 SerialDataIn_tb = 1;
	#64 SerialDataIn_tb = 1;
	#64 SerialDataIn_tb = 0;
	#64 SerialDataIn_tb = 0;
	#64 SerialDataIn_tb = 1;
	#64 SerialDataIn_tb = 1;
end

/*********************************************************/
initial begin // Clear RX
	#0 Clear_RX_Flag_tb = 0;
	#724 Clear_RX_Flag_tb = 1;
	#5 Clear_RX_Flag_tb = 0;
end


endmodule