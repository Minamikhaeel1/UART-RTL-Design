module fsm (
input data_valid ,
input par_en , 
input ser_done , 
input clk , 
input rst , 
output reg ser_en , 
output reg [1:0] mux_sel , 
output reg busy 
);

localparam          idle  = 3'b000 ,
                    serial = 3'b001 ,                    
                    proc = 3'b011 ,
					parity = 3'b010,
					done = 3'b110;
					

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
			if(data_valid && !busy)
				begin
					next_state = serial;
				end
			else 
				begin
					next_state = idle;
				end
		end
		
		serial : 
		begin
			if (!data_valid && !ser_done)
				begin
					next_state = proc;
				end
				
			else 
				begin
					next_state = serial ; 
				end
		end
		
		proc : 
		begin 
			if (ser_done && !par_en)
				begin
					next_state = done;
				end
				
			else if (ser_done && par_en)
				begin
					next_state = parity ; 
				end
			else 
				begin
					next_state = proc;
				end
		end
		
		
		parity : 
		begin
			next_state = done ;
		end
		
		default : 
		next_state = idle ;

	
	endcase
end



always@(*) 
begin 
	ser_en = 1'b0 ;
	busy = 1'b0 ; 
	mux_sel= 2'b01;
	
	case (current_state) 
	
	idle : 
	begin 
		ser_en = 1'b0 ;
		busy = 1'b0 ; 
		mux_sel= 2'b01;
	end
	
	serial : 
	begin 
		ser_en = 1'b1 ;
		busy = 1'b1 ; 
		mux_sel= 2'b00;
	end
	
	proc : 
	begin 
		ser_en = 1'b0 ;
		busy = 1'b1 ; 
		mux_sel= 2'b10;
	end
	
	parity : 
	begin 
		ser_en = 1'b0 ;
		busy = 1'b1 ; 
		mux_sel= 2'b11;
	end
	
	done : 
	begin 
		ser_en = 1'b0 ;
		busy = 1'b1 ; 
		mux_sel= 2'b01;
	end
	
	
	
	endcase
end 

endmodule


