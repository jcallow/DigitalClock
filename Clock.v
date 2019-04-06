module Clock(
		input_clock,
		debug,
		output_clock
);

input input_clock;
input debug;

output output_clock;

parameter debug_step = 120;
parameter output_freq = 2;
parameter input_freq = 50000000;

parameter output_time = input_freq/output_freq;

reg [31:0] count;
reg out_signal;

wire [31:0] step_size;

assign step_size = debug ? debug_step : 1;

always @ (posedge input_clock)
begin
	if (count >= output_time)
	begin
		count <= 0;
		out_signal <= 0;
	end
	
	else if (count >= output_time/2)
	begin
		out_signal <= 1;
		count <= count + step_size;
	end
	
	else if (count < output_time/2)
	begin
		out_signal <= 0;
		count <= count + step_size;
	end
end

assign output_clock = out_signal;

endmodule



module clock_testbench;

parameter debug_step = 10;
parameter output_freq = 10;
parameter input_freq = 50;

reg input_clock;
reg debug;
wire output_clock;
	
initial begin
	$display($time, " << Starting the Simulation >>");
	input_clock = 1'b0;
	debug = 1'b0;
	
	wait (output_clock == 1'b1);
	$display($time, "we did it ");
	
	#40;
	
	$stop;
end

always
	#10 input_clock = ~input_clock;
	
Clock 
	#(
	.debug_step(debug_step),
	.output_freq(output_freq),
	.input_freq(input_freq)
	) clock
	(
	.input_clock(input_clock),
	.debug(debug),
	.output_clock(output_clock)
	);

endmodule
	