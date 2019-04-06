module SevenSegmentDisplayInterface(
	seconds,
	hex0,
	hex1,
	hex2,
	hex3,
	hex4,
	hex5
);

input [31:0] seconds;

output [6:0] hex0;
output [6:0] hex1;
output [6:0] hex2;
output [6:0] hex3;
output [6:0] hex4;
output [6:0] hex5;


wire [3:0] bcd0;
wire [3:0] bcd1;
wire [3:0] bcd2;
wire [3:0] bcd3;
wire [3:0] bcd4;
wire [3:0] bcd5;

wire [31:0] bcd0_temp;
wire [31:0] bcd1_temp;
wire [31:0] bcd2_temp;
wire [31:0] bcd3_temp;
wire [31:0] bcd4_temp;
wire [31:0] bcd5_temp;

assign bcd0_temp = seconds % 10;
assign bcd1_temp = (seconds/10) % 6;
assign bcd2_temp = (seconds/60) % 10;
assign bcd3_temp = (seconds/600) % 6;
assign bcd4_temp = (seconds/3600) % 10;
assign bcd5_temp = (seconds/36000) % 10;

assign bcd0 = bcd0_temp[3:0];
assign bcd1 = bcd1_temp[3:0];
assign bcd2 = bcd2_temp[3:0];
assign bcd3 = bcd3_temp[3:0];
assign bcd4 = bcd4_temp[3:0];
assign bcd5 = bcd5_temp[3:0];

SevenSegmentDisplay seg0 (
	.bcd(bcd0),
	.seg7(hex0)
);

SevenSegmentDisplay seg1 (
	.bcd(bcd1),
	.seg7(hex1)
);

SevenSegmentDisplay seg2 (
	.bcd(bcd2),
	.seg7(hex2)
);

SevenSegmentDisplay seg3 (
	.bcd(bcd3),
	.seg7(hex3)
);

SevenSegmentDisplay seg4 (
	.bcd(bcd4),
	.seg7(hex4)
);

SevenSegmentDisplay seg5 (
	.bcd(bcd5),
	.seg7(hex5)
);

endmodule
