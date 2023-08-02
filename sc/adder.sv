module adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

   logic C0,C1,C2;
	
	CRA_unit ripple_adder0 (.A (A[3:0]), .B (B[3:0]), .Cin (0), .Sum (Sum[3:0]), .Cout (C0));

	CSA_unit select_adder1 (.A (A[7:4]), .B (B[7:4]), .Cin (C0), .Sum (Sum[7:4]), .Cout (C1));
	
	CSA_unit select_adder2 (.A (A[11:8]), .B (B[11:8]), .Cin (C1), .Sum (Sum[11:8]), .Cout (C2));

	CSA_unit select_adder3 (.A (A[15:12]), .B (B[15:12]), .Cin (C2), .Sum (Sum[15:12]), .Cout (CO));
     
endmodule



module CSA_unit(
			input [3:0] 	A,B,
			input 			Cin, 
			output 			Cout,
			output[3:0] 	Sum
);

	logic 		C0,C1;
	logic[3:0]  S0,S1;
	
	CRA_unit ripple_adder0 (.A (A[3:0]), .B (B[3:0]), .Cin (0), .Sum (S0[3:0]), .Cout (C0));

	CRA_unit ripple_adder1 (.A (A[3:0]), .B (B[3:0]), .Cin (1), .Sum (S1[3:0]), .Cout (C1));
	
	assign Cout = C0|(C1&Cin);
	assign Sum= Cin ? S1:S0;

endmodule





module full_adder
(
	input x,y,cin,
	output s,cout
);
	assign s = x^y^cin;
	assign cout =  (x&y)|(y&cin)|(x&cin);
endmodule




module CRA_unit
(
    input   logic[3:0]     A,B,
	 input	logic          Cin,
    output  logic[3:0]     Sum,
    output  logic           Cout
);

	logic c1,c2,c3;
   full_adder f1 (.x (A[0]), .y (B[0]), .cin (Cin), .s (Sum[0]), .cout (c1));
	full_adder f2 (.x (A[1]), .y (B[1]), .cin (c1), .s (Sum[1]), .cout (c2));
	full_adder f3 (.x (A[2]), .y (B[2]), .cin (c2), .s (Sum[2]), .cout (c3));
	full_adder f4 (.x (A[3]), .y (B[3]), .cin (c3), .s (Sum[3]), .cout (Cout));
	
endmodule