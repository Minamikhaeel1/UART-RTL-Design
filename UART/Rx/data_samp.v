module data_samp(
input Rx_in ,
input [5:0] prescale,
input data_samp_en , 
input [5:0]edge_cnt , 
input clk ,
input rst ,
output reg sampled_bit
);

reg s1 , s2 , s3 ; 

always @(posedge clk or negedge rst)
begin 
	if (!rst)
		begin
			s1 <= 1'b1 ; 
			s2 <= 1'b1 ; 
			s3 <= 1'b1 ; 
		end
	else if (data_samp_en)
		begin 
			case(edge_cnt) 
			
			(prescale/2)-1 : 
				begin 
					s1<=Rx_in;
				
				end
			
			(prescale/2) : 
				begin 
					s2<=Rx_in;
				end
			
			(prescale/2)+1 : 
				begin 
					s3<=Rx_in;
				end
			endcase
		end
	
	
	
	case ({s1,s2,s3})
	3'b000   :  sampled_bit <= 1'b0;
	3'b001   :  sampled_bit <= 1'b0;
	3'b010   :  sampled_bit <= 1'b0;
	3'b011   :  sampled_bit <= 1'b1;
	3'b100   :  sampled_bit <= 1'b0;
	3'b101   :  sampled_bit <= 1'b1;
	3'b110   :  sampled_bit <= 1'b1;
	3'b111   :  sampled_bit <= 1'b1;  
	endcase
end
endmodule