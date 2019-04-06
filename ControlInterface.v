module ControlInterface(
	reset,
	sw1,
	sw2,
	sw3,
	sw4,
	key0,
	key2,
	key3,
	time_set,
	alarm_set,
	minutes_up,
	hours_up,
	alarm_on,
	alarm_reset,
	debug
);

// These should probably be debounced

input reset;
input sw1;
input sw2;
input sw3;
input sw4;
input key0;
input key2;
input key3;

output time_set;
output alarm_set;
output minutes_up;
output hours_up;
output alarm_on;
output alarm_reset;
output debug;

assign time_set = sw1 && !(sw2 && reset);
assign alarm_set = sw2 & !(sw1 && reset);
assign minutes_up = !key2;
assign hours_up = !key3;
assign alarm_on = sw3;
assign alarm_reset = !key0 || reset;
assign debug = sw4;

endmodule
