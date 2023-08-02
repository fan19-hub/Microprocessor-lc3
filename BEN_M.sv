module BEN_M(input logic [15:0]IR, input logic LD_BEN,Clk, input logic [2:0] nzpvalue, output logic BEN);
	always_ff @ (posedge Clk)
	begin
		if(LD_BEN)
			begin
				if((nzpvalue[2] & IR[11]) | (nzpvalue[1] & IR[10]) | (nzpvalue[0] & IR[9]) )
					BEN<= 1'b1;
				else
					BEN<= 1'b0;
			end
	end
	
endmodule