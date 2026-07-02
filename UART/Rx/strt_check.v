module strt_check(
input strt_chk_en ,
input sampled_bit , 
output reg strt_glitch
);

always @(*) 
	begin
		case (strt_chk_en) 
		1'b0 : 
			begin
				strt_glitch=1'b0;
			end
			
		1'b1 : 
			begin
				if (sampled_bit == 1'b0)
					begin
						strt_glitch=1'b0;
					end
				else 
					begin
						strt_glitch=1'b1;
					end
				
			end
		endcase
			
	end
	
endmodule