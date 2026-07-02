module fsm(
input Rx_in ,
input [3:0] bit_cnt ,
input par_err , 
input strt_glitch , 
input  stp_err , 
input par_en , 
input clk ,
input rst ,
input [5:0] edge_cnt,
input [5:0] prescale,
output reg dat_samp_en , 
output reg enable , 
output reg deser_en , 
output reg data_valid, 
output reg stp_chk_en ,
output reg strt_chk_en ,
output reg par_chk_en 
);



localparam          idle  = 3'b000 ,
                    start_bit = 3'b001 ,                    
                    data = 3'b011 ,
					parity = 3'b010,
					stop_bit = 3'b110,
					done = 3'b111;
					
					

reg      [2:0]      current_state ,
                    next_state ;
					
					
always @ (posedge clk or negedge rst )
begin
	if (!rst)
		begin 
			current_state <= idle ;
		end
	else 
		begin 
			current_state <= next_state;
		end
end

always@(*)
begin
	case (current_state)
		
		idle : 
			begin 
				if (!Rx_in)
					begin 
						next_state = start_bit;
					end
				else 
					begin 
						next_state = idle;
					end
			end
			
		start_bit : 
			begin 
				if (bit_cnt == 4'b1 && !strt_glitch)
					begin 
						next_state = data;
					end
				else if (bit_cnt == 4'b1 && strt_glitch)
					begin 
						next_state = idle;
					end
				else 
					begin 
						next_state = start_bit;
					end
			end
			
		data : 
			begin 
				if (par_en && bit_cnt ==4'b1001)
					begin 
						next_state = parity;
					end
				else if (!par_en && bit_cnt ==4'b1001)
					begin 
						next_state = stop_bit;
					end
				else 
					begin 
						next_state = data;
					end
			end
			
		parity : 
			begin 
				if (!par_err && bit_cnt ==4'b1010)
					begin 
						next_state = stop_bit;
					end
				else if (par_err && bit_cnt ==4'b1010)
					begin 
						next_state = idle;
					end
				else 
					begin 
						next_state = parity;
					end
			end
			
		stop_bit : 
			begin 
				if (!stp_err && edge_cnt == prescale - 2'b10)
					begin 
						next_state = done;
					end
				else if (stp_err && edge_cnt == prescale - 2'b10 )
					begin 
						next_state = idle;
					end
				else 
					begin 
						next_state = stop_bit;
					end
			end
			
		done : 
			begin 
				next_state = idle;
			end
			
	endcase
end 	


always @(*)
begin 
		dat_samp_en  = 1'b0;
		enable  = 1'b0;
		deser_en  = 1'b0;
		data_valid  = 1'b0;
		stp_chk_en  = 1'b0;
		strt_chk_en  = 1'b0;
		par_chk_en = 1'b0;



	case (current_state)
	
	
	idle  : 
			begin 
				dat_samp_en  = 1'b0;
				enable  = 1'b0;
				deser_en  = 1'b0;
				data_valid  = 1'b0;
				stp_chk_en  = 1'b0;
				strt_chk_en  = 1'b0;
				par_chk_en = 1'b0;
				if (!Rx_in) //to instatly start count the edges , bits 
					begin 
						dat_samp_en  = 1'b1;
						enable  = 1'b1;
					end
			end
	
	start_bit : 
			begin 
				dat_samp_en= 1'b1;
				enable= 1'b1;
				strt_chk_en= 1'b1;
				
			end
			
	data : 
			begin 
				dat_samp_en= 1'b1;
				enable= 1'b1;
				deser_en= 1'b1;
			end
			
	parity : 
			begin 
				dat_samp_en= 1'b1;
				enable= 1'b1;
				par_chk_en = 1'b1;
			end
			
	stop_bit : 
			begin 
				dat_samp_en= 1'b1;
				enable= 1'b1;
				stp_chk_en  = 1'b1;
				
			end
			
	done : 
			begin 
			data_valid= 1'b1;
			end
			
			
	default : 
			begin 
				dat_samp_en  = 1'b0;
				enable  = 1'b0;
				deser_en  = 1'b0;
				data_valid  = 1'b0;
				stp_chk_en  = 1'b0;
				strt_chk_en  = 1'b0;
				par_chk_en = 1'b0;
			end
		
	
	
	endcase
end



endmodule
