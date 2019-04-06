module HelloWorld(
							CLOCK_50,
							SW,
							KEY,
							HEX0,
							HEX1,
							HEX2,
							HEX3,
							HEX4,
							HEX5,
							LEDR
						);
						
input CLOCK_50;
input [3:0] KEY;
input [4:0] SW;

wire reset = SW[0];
wire time_set;
wire alarm_set;
wire minutes_up;
wire hours_up;
wire alarm_on;
wire alarm_reset;
wire debug;

wire clock;

Clock clock1 (
	.input_clock(CLOCK_50),
	.debug(debug),
	.output_clock(clock)
);

wire seconds_tick;

Clock #(.output_freq(1)) seconds_tick_clock (
	.input_clock(CLOCK_50),
	.debug(debug),
	.output_clock(seconds_tick)
);

ControlInterface controlInterface(
	.reset(reset),
	.sw1(SW[1]),
	.sw2(SW[2]),
	.sw3(SW[3]),
	.sw4(SW[4]),
	.key0(KEY[0]),
	.key2(KEY[2]),
	.key3(KEY[3]),
	.time_set(time_set),
	.alarm_set(alarm_set),
	.minutes_up(minutes_up),
	.hours_up(hours_up),
	.alarm_on(alarm_on),
	.alarm_reset(alarm_reset),
	.debug(debug)
);


wire [31:0] current_time;

Time clockTime (
	.clk(clock),
	.seconds_tick(seconds_tick),
	.reset(reset),
	.set(time_set),
	.minute_up(minutes_up),
	.hour_up(hours_up),
	.out_time(current_time)
);

wire [31:0] alarm_time;

Time alarmTime (
	.clk(clock),
	.seconds_tick(1'b0),
	.reset(reset),
	.set(alarm_set),
	.minute_up(minutes_up),
	.hour_up(hours_up),
	.out_time(alarm_time)
);

wire [31:0] display_time;
wire alarm_went_off;

TimeController timeController (
	.clk(clock),
	.reset(reset),
	.current_time(current_time),
	.alarm_time(alarm_time),
	.time_set(time_set),
	.alarm_set(alarm_set),
	.alarm_on(alarm_on),
	.alarm_reset(alarm_reset),
	.display_time(display_time),
	.alarm_went_off(alarm_went_off)
);

output 	[6:0]		HEX0;
output 	[6:0]		HEX1;
output 	[6:0]		HEX2;
output 	[6:0]		HEX3;
output 	[6:0]		HEX4;
output 	[6:0]		HEX5;

SevenSegmentDisplayInterface segInterface (
	.seconds(display_time),
	.hex0(HEX0),
	.hex1(HEX1),
	.hex2(HEX2),
	.hex3(HEX3),
	.hex4(HEX4),
	.hex5(HEX5)
);

output	[9:0] LEDR;

assign LEDR[8] = 0;
assign LEDR[6:5] = 0;

LedDisplayInterface ledInterface (
	.sw0(reset),
	.sw1(time_set),
	.sw2(alarm_set),
	.sw3(alarm_on),
	.sw4(debug),
	.blink(seconds_tick),
	.alarm(alarm_went_off),
	.led0(LEDR[0]),
	.led1(LEDR[1]),
	.led2(LEDR[2]),
	.led3(LEDR[3]),
	.led4(LEDR[4]),
	.led7(LEDR[7]),
	.led9(LEDR[9])
);


endmodule
