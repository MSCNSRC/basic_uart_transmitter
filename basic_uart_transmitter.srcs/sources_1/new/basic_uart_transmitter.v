`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2023 22:27:43
// Design Name: 
// Module Name: basic_uart_transmitter
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


module basic_uart_transmitter
#(parameter DATA_BIT_SAYISI  = 8   ,
            STOP_BIT_SAYISI  = 2   ,
			BAUD_RATE_DEGERI = 921600 )
(
	input  wire                         clk, reset  ,
	input  wire [DATA_BIT_SAYISI-1 : 0] data_giris  ,
	
	output reg                          data_cikis
);

localparam  RESET_STATE = 3'b000,
            SEND_EN     = 3'b001,
			SEND_DATA   = 3'b010,
//SEND_PARITY = 3'b011,
			SEND_STOP   = 3'b100;
	
	reg  [DATA_BIT_SAYISI-1 : 0] shift_reg      , shift_next      , data_register ;
	reg  [8                 : 0] veri_sayaci_reg, veri_sayaci_next                ;
	reg  [2                 : 0] state_reg      , state_next                      ;
	wire                         clock_gen                                        ;

baud_rate_generator #(BAUD_RATE_DEGERI, 100000000)clock_generator (.clk_cikis(clock_gen),
													               .clk_giris(clk)      ,
													               .reset(reset)         );

	always @(posedge clock_gen, posedge reset)
	begin
		if (reset)
		begin
			state_reg       <= RESET_STATE;
			veri_sayaci_reg <= 8'd0       ;
			shift_reg       <= 0          ;
		end
		
		else
		begin
			state_reg       <= state_next       ;
			veri_sayaci_reg <= veri_sayaci_next ;
			shift_reg       <= shift_next       ;
		end
	end
	
	always @(*)
	begin
		data_register = data_giris;
	end
	
	
	always @(*)
	begin
	data_cikis        = 1'b1       ;
	veri_sayaci_next  = 8'd0       ;
	shift_next        = 0          ;
	state_next        = RESET_STATE;
	
	
		case (state_reg)
			RESET_STATE:
			begin
				data_cikis        = 1'b1    ;
				veri_sayaci_next  = 8'd0    ;
				shift_next        = 0       ;
				state_next        = SEND_EN ;
				
			end
			
			SEND_EN:
			begin
				data_cikis        = 1'b0          ;
				veri_sayaci_next  = 8'd0          ;
				shift_next        = data_register ;
				state_next        = SEND_DATA     ;
			end
			
			SEND_DATA:
			begin
			
				data_cikis       = shift_reg[0] ;
				
				
				if (veri_sayaci_reg == (DATA_BIT_SAYISI-1))
				begin
				
					veri_sayaci_next = 8'd0      ;
					shift_next       = 0         ;  		
					state_next       = SEND_STOP ;
				
				end
				
				else
				begin
					
					veri_sayaci_next = veri_sayaci_reg + 1'b1 ;
					shift_next       = shift_reg >> 1'b1      ;  		
					state_next       = SEND_DATA              ;
				end
			end
			
			SEND_STOP:
			begin
				if (veri_sayaci_reg == (STOP_BIT_SAYISI-1))
				begin
					data_cikis        = 1'b1   ;
					veri_sayaci_next  = 8'd0   ;
					shift_next        = 0      ;
					state_next        = SEND_EN;
				end
				
				else
				begin
					data_cikis        = 1'b1                   ;
					veri_sayaci_next  = veri_sayaci_reg + 1'b1 ;
					shift_next        = 0                      ;
					state_next        = SEND_STOP              ;
				end
			end
			
			
		endcase
		
	
	end

endmodule
