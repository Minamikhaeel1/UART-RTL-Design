module stop_check(
input stp_chk_en ,
input sampled_bit , 
output reg stp_err
);

always @(*) 
	begin
		case (stp_chk_en) 
		1'b0 : 
			begin
				stp_err=1'b0;
			end
			
		1'b1 : 
			begin
				if (sampled_bit == 1'b1)
					begin
						stp_err=1'b0;
					end
				else 
					begin
						stp_err=1'b1;
					end
				
			end
		endcase
			
	end
	
endmodule