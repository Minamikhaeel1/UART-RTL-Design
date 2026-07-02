module deser(
input sampled_bit , 
input deser_en , 
input [3:0] bit_cnt , 
input [5:0] edge_cnt , 
input [5:0] prescale,
input clk ,
input rst ,
input par_en , 
output reg [7:0] p_data 
);

reg [7:0] shift_reg;

always @(posedge clk or negedge rst)
begin
	if (!rst)
		begin
			p_data <=8'b0;
			shift_reg <=8'b0;
		end
	else if(deser_en)
		begin 
			if ( bit_cnt < 4'b1001 && edge_cnt == (prescale/2)+2'b10 )
				begin
					shift_reg[bit_cnt-1'b1] <=sampled_bit;
				end
			else if(bit_cnt== 4'b1001)
				begin
					p_data<=shift_reg;
				end
			
		end
	
	


		
end

endmodule