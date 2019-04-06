module Time(
	clk,
	seconds_tick,
	reset,
	set,
	minute_up,
	hour_up,
	out_time
);

input clk;
input seconds_tick;
input reset;
input set;
input minute_up;
input hour_up;

output [31:0] out_time;

wire seconds_out_tick;
wire [31:0] seconds_out;
TimeComponent seconds (
	.reset(reset || set),
	.clk(clk),
	.tick(seconds_tick),
	.set(1'b0),
	.increment(1'b0),
	.out_tick(seconds_out_tick),
	.output_value(seconds_out)
);

wire minutes_tick = seconds_out_tick && seconds_tick;
wire minutes_out_tick;
wire [31:0] minutes_out;
TimeComponent minutes (
	.reset(reset),
	.clk(clk),
	.tick(minutes_tick),
	.set(set),
	.increment(minute_up),
	.out_tick(minutes_out_tick),
	.output_value(minutes_out)
);

wire hours_tick = minutes_out_tick && minutes_tick;
wire hours_out_tick;
wire [31:0] hours_out;
TimeComponent #(.roll_over(24)) hours  (
	.reset(reset),
	.clk(clk),
	.tick(hours_tick),
	.set(set),
	.increment(hour_up),
	.out_tick(hours_out_tick),
	.output_value(hours_out)
);

assign out_time = seconds_out + (60*minutes_out) + (60*60*hours_out);

endmodule
