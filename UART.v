/******************************************************************* 
* Name:
*	UART.v
* Description:
* 	This is a UART full duplex module
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
*	V1.0       25/10/2018
* 
*********************************************************************/

module UART
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

wire shift_RX;
wire shift_TX;
wire [WORD_LENGTH-1:0] DATA_RX_wir;
wire RX_ready;
wire load;
wire transmit_int;

wire RX_FLAG_EN;

// Modules implementation 

assign DATARX = DATA_RX_wir;

//------RX modules

RX_SR
#(
	.WORD_LENGTH(WORD_LENGTH)
) 
SR_RX			  					 	//RX input shift register
(
	.SerialDataIn(SerialDataIn),
	.clk(clk),
	.reset(reset),
	.shift(shift_RX),
	
	.DataRX(DATA_RX_wir)

);

RX_FSM
#(
	.WORD_LENGTH(WORD_LENGTH)
) 
FSM_RX						   	//RX input FSM
(
	.SerialDataIn(SerialDataIn),
	.clk(clk),
	.reset(reset),
	
	.shift_RX(shift_RX),
	.ready(RX_ready)

);



//------TX modules

TX_SR
#(
	.WORD_LENGTH(WORD_LENGTH)
) 
SR_TX			  					 	//TX output shift register
(
	.clk(clk),
	.reset(reset),
	.shift(shift_TX),
	.load(load),
	.DataTX(DATATX),
	.transmit_int(transmit_int),
	
	.SerialDataOut(SerialDataOut)

);

TX_FSM
#(
	.WORD_LENGTH(WORD_LENGTH)
) 
FSM_TX						   	//TX output FSM
(
	.clk(clk),
	.reset(reset),
	.transmit(Transmit),
	
	.load(load),
	.transmit_int(transmit_int),
	.shift_TX(shift_TX)

);

//----Register

Register
#(
	.WORD_LENGTH(1)
) 
RX_FLAG_REG			  					 	//RX ready flag register
(
	.clk(clk),
	.reset(reset),
	.enable(RX_FLAG_EN),
	.Data_Input(RX_ready),
	
	.Data_Output(RX_FLAG)

);

assign RX_FLAG_EN = RX_ready | Clear_RX_Flag;


endmodule