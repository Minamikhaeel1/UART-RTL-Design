module parity (
input data_valid ,
input [7:0] P_data , 
input par_type , 
input [1:0]mux_sel ,
input clk ,
input rst ,
output reg par_bit 
);

reg   [7 : 0] shift_reg ;
reg flag ;

always @(*)
	begin 
		 par_bit = par_type ? ~(^shift_reg) : (^shift_reg);
		 flag = data_valid ? 1'b1 : 1'b0 ; 
	end 


always @(posedge clk or negedge rst)
begin
	if (!rst)
		begin
			shift_reg <= 8'b0;
			
		end
	else if(flag && (mux_sel==2'b0 || mux_sel ==2'b01 ))
		begin
			shift_reg <= P_data;
		end
	
end

endmodule