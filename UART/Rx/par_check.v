module par_check(
input par_type , 
input par_chk_en , 
input sampled_bit , 
input [7:0] P_data,
output reg par_err 
);

always @(*)
begin
	if (par_chk_en && par_type)//odd parity
		begin 
			if(sampled_bit == ~(^P_data))
				begin 
					par_err = 1'b0; 
				end
			else 
				begin 
					par_err = 1'b1; 
				end
		end
		
	
	else if (par_chk_en && !par_type) // even par
		begin
			if(sampled_bit == (^P_data))
				begin 
					par_err = 1'b0; 
				end
			else 
				begin 
					par_err = 1'b1; 
				end

		end
	else 
		par_err = 1'b0; 
end


endmodule

