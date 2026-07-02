`timescale 1ns/1ps ;
module rx_top_tb();

////////////////////////////////////////////////////////
/////////////////// parameters  //////////////////////// 
////////////////////////////////////////////////////////
parameter TX_CLK_PERIOD = 8680; //115.2k


////////////////////////////////////////////////////////
/////////////////// DUT signals ////////////////////////
////////////////////////////////////////////////////////
reg clk_tb;
reg rst_tb;
reg par_en_tb;
reg par_typ_tb;
reg [5:0] prescale_tb;
reg rx_in_tb;
wire [7:0] P_data_tb;
wire data_valid_tb, par_err_tb, stp_err_tb;


////////////////////////////////////////////////////////
/////////////////// RX_CLK generation //////////////////
////////////////////////////////////////////////////////
real RX_CLK_PERIOD;
always @(*) 
	begin
		RX_CLK_PERIOD = TX_CLK_PERIOD / prescale_tb;
	end


////////////////////////////////////////////////////////
/////////////////// DUT Instantation ///////////////////
////////////////////////////////////////////////////////
uart_rx_top dut (
	.clk_t(clk_tb),
	.rst_t(rst_tb),
	.par_en_t(par_en_tb),
	.par_type_t(par_typ_tb),
	.prescale_t(prescale_tb),
	.rx_in_t(rx_in_tb),
	.p_data_t(P_data_tb),
	.data_valid_t(data_valid_tb),
	.par_err_t(par_err_tb),
	.stop_err_t(stp_err_tb)
);


////////////////////////////////////////////////////////
////////////////// initial block /////////////////////// 
////////////////////////////////////////////////////////
initial 
	begin
	$dumpfile("uart_rx_top.vcd");       
	$dumpvars; 
 
	initialize();
	reset();
	
	
	prescale_tb = 6'b1000;
	transmiting(8'b01110010,1'b0,1'b0); // data , parity enable , parity type
	#(TX_CLK_PERIOD);
	transmiting(8'b01111010,1'b1,1'b1);
	#(TX_CLK_PERIOD);
	transmiting(8'b10000010,1'b1,1'b0);
	#(TX_CLK_PERIOD);
	transmiting(8'b10100010,1'b1,1'b0);
	#(TX_CLK_PERIOD);
	
	//consecutive packets
	transmiting(8'b10111010,1'b1,1'b0);
	transmiting(8'b10100110,1'b1,1'b0);
	#(TX_CLK_PERIOD);
	
	// 16 oversampling
	prescale_tb = 6'b10000;
	transmiting(8'b10100010,1'b1,1'b0);
	#(TX_CLK_PERIOD);
	
	// 32 oversampling
	prescale_tb = 6'b100000;
	transmiting(8'b10111010,1'b1,1'b0);
	
	#100;  
    $finish;
	end






////////////////////////////////////////////////////////
////////////////// Clock Generator  ////////////////////
////////////////////////////////////////////////////////
always #(RX_CLK_PERIOD/2)  clk_tb = ~clk_tb ;



////////////////////////////////////////////////////////
/////////////////////// TASKS //////////////////////////
////////////////////////////////////////////////////////

/////////////// Signals Initialization /////////////////
task initialize;
        begin
            clk_tb = 1'b0;
            rst_tb = 1'b1;
            prescale_tb = 6'b1000;
			par_en_tb =1'b0;
			par_typ_tb =1'b0;
			rx_in_tb = 1'b1;
			
        end
    endtask

///////////////////////// RESET /////////////////////////
task reset;
        begin
			#(RX_CLK_PERIOD);
            rst_tb = 1'b0; 
            #(RX_CLK_PERIOD );
            rst_tb = 1'b1;
            #(RX_CLK_PERIOD);
        end
    endtask
	
	
	
	
	///////////////////////// transmit packet /////////////////////////
task transmiting(
        input [7:0] data,
        input parity_enable,
        input parity_type);
		integer i ;
        begin
			
			
			par_en_tb = parity_enable;
			par_typ_tb = parity_type;
            rx_in_tb = 0; // start bit
            #(TX_CLK_PERIOD);
            for (i = 0; i < 8; i = i + 1) 
				begin
					rx_in_tb = data[i];
					#(TX_CLK_PERIOD);
				end
            if (parity_enable) 
				begin
					rx_in_tb = (parity_type) ? ~^data : ^data; // odd/even parity
					#(TX_CLK_PERIOD);
				end
            rx_in_tb = 1; // stop bit
            #(TX_CLK_PERIOD);
			if(data == P_data_tb)
				begin
					$display("packet recived correctly");
				end
			else 
				begin
					$display("packet recive fail");
				end
			
        end
    endtask

endmodule