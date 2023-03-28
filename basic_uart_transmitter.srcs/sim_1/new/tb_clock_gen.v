`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2023 20:49:45
// Design Name: 
// Module Name: tb_clock_gen
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


module tb_clock_gen;

reg 	r_clock_in  ;
reg 	r_enable_sig;
wire 	r_clock_out ;

always @(*)
begin

	#10;
	r_clock_in <= ~r_clock_in;

end

baud_rate_generator #(25000000,100000000) uut_clok_gen(.clk_cikis(r_clock_out),
													   .enable(r_enable_sig)  ,
													   .clk_giris(r_clock_in)  );
													   
initial
begin

r_enable_sig = 1'b0; r_clock_in = 1'b0;
repeat(15) @(posedge r_clock_in);

r_enable_sig = 1'b1;
repeat(50) @(posedge r_clock_in);


end

endmodule
