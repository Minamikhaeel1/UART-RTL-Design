module ser #(parameter size = 8) (
input [size - 1 : 0] P_data,
input ser_en ,
input clk,
input rst ,
output reg ser_done , 
output reg ser_data

);

 reg  [3:0]  counter ;
 reg   [size - 1 : 0] shift_reg ;
 
 reg flag ;
 
 
 
always @ (posedge clk or negedge rst)
	begin
	if (!rst)
		begin
			ser_data <= 1'b0 ; 
			counter  <= 4'b0 ;
			ser_done <= 1'b0 ;
			shift_reg<= 'b0  ;
			flag <= 1'b0;
		end
	else 
		begin
			if (ser_en)
				begin
					counter <= 4'b1 ; 
					shift_reg <= P_data ; 
					ser_done <= 1'b0 ;
					ser_data <= P_data[0];
					flag <= 1'b1;
					
				end
			else if (counter < 4'b1000 && flag)
				begin 
				
					ser_data  <= shift_reg[1];
					shift_reg[1] <= shift_reg[2];
					shift_reg[2] <= shift_reg[3];
					shift_reg[3] <= shift_reg[4];
					shift_reg[4] <= shift_reg[5];
					shift_reg[5] <= shift_reg[6];
					shift_reg[6] <= shift_reg[7];
					counter <= counter + 1'b1 ;

				end
			else 
				begin
					
					flag <= 1'b0;
					counter <= 4'b1 ;
					
				end
		end	
		
	
		
		
		
	end
	
	always @(*)
		begin
		  if(counter == 4'b1000)
		    begin
		      ser_done = 1'b1 ;
		      
		    end
		   else
		      ser_done = 1'b0 ;
		end
	endmodule