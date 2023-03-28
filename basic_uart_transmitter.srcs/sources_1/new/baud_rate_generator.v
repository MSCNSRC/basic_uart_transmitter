`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2023 20:38:29
// Design Name: 
// Module Name: baud_rate_generator
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module baud_rate_generator
#(parameter BAUD_RATE_DEGERI = 9600,
			SISTEM_FREKANSI  = 100000000)
(
	input  wire reset, clk_giris,
	
	output reg  clk_cikis
);

parameter MAX_SAYAC_DEGERI = (SISTEM_FREKANSI/(BAUD_RATE_DEGERI * 2));

reg [31:0] clock_sayac;

always @(posedge clk_giris, posedge reset)
begin
	
	if (reset)
	begin
		clock_sayac <= 0   ;
		clk_cikis   <= 1'b0;
	end
	
	else
	begin
		if(MAX_SAYAC_DEGERI - 1 == clock_sayac)
		begin
			clk_cikis   <= ~clk_cikis ;
			clock_sayac <= 0          ;
		end
		
		else
		begin
			clk_cikis   <= clk_cikis         ;
			clock_sayac <= clock_sayac + 1'b1;
		end
		
	end

end

endmodule
