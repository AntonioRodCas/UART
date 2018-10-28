/******************************************************************* 
* Name:
*	UART_MOD.v
* Description:
* 	This is a UART full duplex module with PLL 
* Inputs:
*  SerialDataIn: Serial Data Input 
*	clk: Clock signal 
*  reset: Reset signal
*  Clear_RX_Flag: Clear RX flag input signal
*  DataTX: TX data to be transmited
*  Transmit: Start of transmit trigger signal.
* Outputs:
*  DataRX: RX data read on serial input
*  RX_FLAG: RX ready flag.
*  SerialDataOut: Serial Data Output
*  ParityError: Parity Error flag
* Versión:  
*	1.0
* Author: 
*	José Antonio Rodríguez Castañeda  md193781
* Date :
*	V1.0       27/10/2018
* 
*********************************************************************/

module UART_MOD
#(
	parameter WORD_LENGTH = 8
)

(
	input SerialDataIn,
	input clk,
	input reset,
	input Clear_RX_Flag,
	input [WORD_LENGTH-1:0] DATATX,
	input Transmit,
	
	output [WORD_LENGTH-1:0] DATARX,
	output RX_FLAG,
	output SerialDataOut,
	output ParityError
	

);

wire clk_int;
wire Transmit_neg;
wire Transmit_debounce;

assign Transmit_neg = ~Transmit;

UART
#(
	.WORD_LENGTH(WORD_LENGTH)
) 
UART_inst			  					 	//UART instance
(
	.SerialDataIn(SerialDataIn),
	.clk (clk_int),
	.reset(reset),
	.Clear_RX_Flag(Clear_RX_Flag),
	.DATATX(DATATX),
	.Transmit(Transmit_debounce),
	
	.DATARX(DATARX),
	.RX_FLAG(RX_FLAG),
	.SerialDataOut(SerialDataOut),
	.ParityError(ParityError)

);


clk_gen
clock_gen			   	//Clock Divider with PLL to generate 153.846kHz
(
	.clk(clk),
	.reset(reset),
	
	.clk_out(clk_int)

);


One_Shot
 ShotModule
(
	// Input Ports
	.clk(clk_int),
	.reset(reset),
	.Start(Transmit_neg),

	// Output Ports
	.Shot(Transmit_debounce)
);


endmodule
