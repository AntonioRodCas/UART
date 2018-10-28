/******************************************************************* 
* Name:
*	RX_SR.v
* Description:
* 	This module is a shift register with parameter for RX of the UART.
* Inputs:
*  SerialDataIn: Serial Data Input 
*	clk: Clock signal 
*  reset: Reset signal
*  shift: Shift enable input
* Outputs:
* 	DataRX: Parallel Data Output
* Versión:  
*	1.0
* Author: 
*	José Antonio Rodríguez Castañeda  md193781
* Date :
*	V1.0       24/10/2018
* 
*********************************************************************/

module RX_SR
#(
	parameter WORD_LENGTH = 8
)

(
	input SerialDataIn,
	input clk,
	input reset,
	input shift,
	
	output reg [WORD_LENGTH - 1 : 0] DataRX

);

always @(posedge clk or negedge reset) 
begin
	if(reset==1'b0) 
	begin
		DataRX<= {(WORD_LENGTH-1) {1'b0}};
	end
	
	else 
		if (shift)
			DataRX<={SerialDataIn , DataRX[WORD_LENGTH-1:1]};
	
		else
			DataRX<=DataRX;

end



endmodule