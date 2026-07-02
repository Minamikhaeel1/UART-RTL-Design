module mux (
input [1:0] mux_sel ,
input ser_data ,
input par_bit,
output reg Tx_out 
);


always @(*)
begin 
	
			case (mux_sel)
			2'b00:
			begin 
				Tx_out = 1'b0 ;
			end
			
			2'b01:
			begin 
				Tx_out = 1'b1 ;
			end
			
			2'b10:
			begin 
				Tx_out = ser_data ;
			end
		
			2'b11:
			begin 
				Tx_out = par_bit ;
			end
		
			endcase
		
end
endmodule
