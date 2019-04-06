module TimeController (
	clk,
	reset,
	current_time,
	alarm_time,
	time_set,
	alarm_set,
	alarm_on,
	alarm_reset,
	display_time,
	alarm_went_off
);

input clk;
input reset;

input [31:0] current_time;
input [31:0] alarm_time;
input time_set;
input alarm_set;
input alarm_on;
input alarm_reset;

output [31:0] display_time;
reg alarm_went_off_wire;
output alarm_went_off;


always @ (posedge clk or posedge reset)
begin
	if (reset)
	begin
		alarm_went_off_wire <= 0;
	end
	else if (alarm_reset || !alarm_on)
	begin
		alarm_went_off_wire <= 0;
	end
	else if (alarm_on && (current_time == alarm_time))
	begin
		alarm_went_off_wire <= 1;
	end
end


assign display_time = alarm_set ? alarm_time : current_time;
assign alarm_went_off = alarm_went_off_wire;


endmodule



