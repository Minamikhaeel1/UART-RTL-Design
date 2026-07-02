module parity (
input data_valid ,
input [7:0] P_data , 
input par_type , 
input busy ,
output reg par_bit 
);

always @(posedge data_valid)
begin
	if(!busy)
		begin
			par_bit <= par_type ? ~(^P_data) : (^P_data);
		end

	  

end

endmodule