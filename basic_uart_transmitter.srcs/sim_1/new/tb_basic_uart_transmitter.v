`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2023 23:49:34
// Design Name: 
// Module Name: tb_basic_uart_transmitter
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


module tb_basic_uart_transmitter;

reg r_clk, r_reset;
reg [7:0] r_data_in;

wire w_data_out;

basic_uart_transmitter #(8, 2, 9600) tb_uart_transmitter(.data_cikis(w_data_out),
                                                         .data_giris(r_data_in) ,
														 .clk(r_clk)            ,
														 .reset(r_reset)         );
														 
always @(*)
begin
	if (r_clk)
	begin
		#10;
		r_clk <= 1'b0; 
	end
	
	else 
	begin
		#10;
		r_clk <= 1'b1; 
	end
end

initial
begin
	r_clk = 0;
	r_reset = 1'b1;	r_data_in = 8'b1010_0101; repeat(16)@(posedge r_clk);
	r_reset = 1'b0;	r_data_in = 8'b0000_1111; repeat(1) @(posedge r_clk);
	r_reset = 1'b0;	r_data_in = 8'b1111_1111; repeat(20)@(posedge r_clk);
	$stop;

end


endmodule
