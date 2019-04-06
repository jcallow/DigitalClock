module SevenSegmentDisplay(
								bcd,
								seg7
								);
								
input 	[3:0]	bcd; 

output reg	[6:0]	seg7;

always @*
	case (bcd)
	4'b0000 :      	//Hexadecimal 0
	seg7 <= 7'b1000000;
	4'b0001 :    		//Hexadecimal 1
	seg7 <= 7'b1111001 ;
	4'b0010 :  		// Hexadecimal 2
	seg7 <= 7'b0100100; 
	4'b0011 : 		// Hexadecimal 3
	seg7 <= 7'b0110000;
	4'b0100 :		// Hexadecimal 4
	seg7 <= 7'b0011001;
	4'b0101 :		// Hexadecimal 5
	seg7 <= 7'b0010010;  
	4'b0110 :		// Hexadecimal 6
	seg7 <= 7'b0000010;
	4'b0111 :		// Hexadecimal 7
	seg7 <= 7'b1111000;
	4'b1000 :     		 //Hexadecimal 8
	seg7 <= 7'b0000000;
	4'b1001 :    		//Hexadecimal 9
	seg7 <= 7'b0011000;
	4'b1010 :  		// Hexadecimal A
	seg7 <= 7'b0001000; 
	4'b1011 : 		// Hexadecimal B
	seg7 <= 7'b0000011;
	4'b1100 :		// Hexadecimal C
	seg7 <= 7'b1000110;
	4'b1101 :		// Hexadecimal D
	seg7 <= 7'b0100001;
	4'b1110 :		// Hexadecimal E
	seg7 <= 7'b0000110;
	4'b1111 :		// Hexadecimal F
	seg7 <= 7'b0001110;
	endcase
	
endmodule
