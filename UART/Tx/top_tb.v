`timescale 1ns/1ps ;
module top_tb ();


////////////////////////////////////////////////////////
/////////////////// parameters  //////////////////////// 
////////////////////////////////////////////////////////

parameter size = 8 ;
parameter Clock_PERIOD = 5 ;


////////////////////////////////////////////////////////
/////////////////// DUT Signals //////////////////////// 
////////////////////////////////////////////////////////

reg [size-1 : 0] P_data_tb ; 
reg data_valid_tb ;
reg par_en_tb ; 
reg par_type_tb ; 
reg clk_tb ; 
reg rst_tb ; 
wire Tx_out_tb;
wire busy_tb ;







////////////////////////////////////////////////////////
////////////////// initial block /////////////////////// 
////////////////////////////////////////////////////////


initial 
	begin
	$dumpfile("top.vcd");       
	$dumpvars; 
 
	initialize();
	reset();
	
	$display("frame with parity disabled");
	send_frame(8'b10011, 1'b0, 1'b0);// data , par enable , par type 
	$display("");
	#(Clock_PERIOD * 5);
	
	$display("frame with even parity , expected 0");
	send_frame(8'b110110, 1'b1, 1'b0); //frame with even parity 
	#(Clock_PERIOD * 5);
	
	$display("frame with even parity , expected 1");
	send_frame(8'b1101101, 1'b1, 1'b0); //frame with even parity 
	#(Clock_PERIOD * 5);
	
	$display("frame with odd parity , expected 1");
	send_frame(8'b110110, 1'b1, 1'b1);//frame with odd parity
	#(Clock_PERIOD * 5);
	
	$display("frame with odd parity , expected 0");
	send_frame(8'b1101101, 1'b1, 1'b1);//frame with odd parity
	#(Clock_PERIOD * 5);
	
	$display("check a valid signal during data transmission for a frame with odd parity  ");//check when a valid signal is high in the mid of transmission 
	check_busy(8'b11010100, 1'b1, 1'b1);
	#(Clock_PERIOD * 5);
	
	#100;  
    $finish;
	end









////////////////////////////////////////////////////////
/////////////////////// TASKS //////////////////////////
////////////////////////////////////////////////////////

/////////////// Signals Initialization //////////////////
task initialize;
        begin
            clk_tb = 1'b0;
            rst_tb = 1'b1;
            P_data_tb = 0;
            data_valid_tb = 1'b0;
            par_en_tb = 1'b0;
            par_type_tb = 1'b0;
        end
    endtask
///////////////////////// RESET /////////////////////////

task reset;
        begin
			#(Clock_PERIOD);
            rst_tb = 1'b0; 
            #(Clock_PERIOD * 2);
            rst_tb = 1'b1;
            #(Clock_PERIOD);
        end
    endtask

///////////////////////// send and check a frame /////////////////////////

 task send_frame(
 input [size-1:0] data, 
 input parity_enable, 
 input parity_type);
 integer i ;
        begin
			@(posedge clk_tb);
			      P_data_tb     = data;
            par_en_tb     = parity_enable;
            par_type_tb    = parity_type;
			
			data_valid_tb = 1'b1 ;
			#(Clock_PERIOD);
			data_valid_tb = 1'b0 ;
			#(Clock_PERIOD * 1.25);
			for (i = 0; i < size; i = i + 1)
			begin
				if(P_data_tb[i] == Tx_out_tb)
					begin
						$display("bit %d send succecfuly " , i );
						
						#(Clock_PERIOD);
					end
				else 
					begin
						$display("bit %d corrupted , wrong value   " , i );
						#(Clock_PERIOD);
					end
				
				
			end
			
			if (par_en_tb)
			begin 
				case (par_type_tb)
				1'b0 : //even par
					begin
						if (^P_data_tb == Tx_out_tb)
							begin
								$display(" even parity check passed , value is  " ,  Tx_out_tb);
								$display("");
							end
						else 
							begin
								$display(" even parity check fail with value " , Tx_out_tb );
								$display("");
							end
					
					end
					
					1'b1 : //odd par
					begin
						if (~(^P_data_tb) == Tx_out_tb)
							begin
								$display(" odd parity check passed , value is " , Tx_out_tb);
								$display("");
							end
						else 
							begin 
								$display(" odd parity check fail with value " ,Tx_out_tb);
								$display("");
							end
					
					end
				endcase
			end
			
			
			
			
		end

	endtask

///////////////////////// check a valid sig when busy is high  /////////////////////////

task check_busy (
 input [size-1:0] data, 
 input parity_enable, 
 input parity_type);
 integer i ;
        begin
			@(posedge clk_tb);
			      P_data_tb     = data;
            par_en_tb     = parity_enable;
            par_type_tb    = parity_type;
			
			data_valid_tb = 1'b1 ;
			#(Clock_PERIOD);
			data_valid_tb = 1'b0 ;
			#(Clock_PERIOD * 1.25);
			for (i = 0; i < size; i = i + 1)
			begin
				if(P_data_tb[i] == Tx_out_tb)
					begin
						$display("correctly send bit  " , i );
						data_valid_tb = 1'b1 ;
						#(Clock_PERIOD);
						data_valid_tb = 1'b0 ;
						$display("valid signal doesnt corrupt the transmission ");
					end
				else 
					begin
						$display(" not correct sending bit " , i );
						#(Clock_PERIOD);
					end
				
				
			end
			
			if (par_en_tb)
			begin 
				case (par_type_tb)
				1'b0 : //even par
					begin
						if (^P_data_tb == Tx_out_tb)
						$display(" even parity check passed , value is  " ,  Tx_out_tb);
						else 
						$display(" even parity check fail with value " , Tx_out_tb );
					
					end
					
					1'b1 : //odd par
					begin
						if (~(^P_data_tb) == Tx_out_tb)
						$display(" odd parity check passed , value is " , Tx_out_tb);
						else 
						$display(" odd parity check fail with value " ,Tx_out_tb);
					
					end
				endcase
			end
			
			
			
			
		end

	endtask



////////////////////////////////////////////////////////
////////////////// Clock Generator  ////////////////////
////////////////////////////////////////////////////////

always #2.5  clk_tb = ~clk_tb ;


////////////////////////////////////////////////////////
/////////////////// DUT Instantation ///////////////////
////////////////////////////////////////////////////////

top DUT (
.P_data_t(P_data_tb),
.data_valid_t(data_valid_tb),
.par_en_t(par_en_tb),
.par_type_t(par_type_tb),
.clk_t(clk_tb),
.rst_t(rst_tb),
.Tx_out_t(Tx_out_tb),
.busy_t(busy_tb)

);

endmodule