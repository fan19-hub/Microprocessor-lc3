module CC(input logic [15:0] Data_from_BUS,input logic LD_CC,Clk, output logic [2:0] nzpvalue);
	always_ff @ (posedge Clk)
	begin
		if (LD_CC) 
			begin
				if(Data_from_BUS[15])
					nzpvalue <= 3'b100;
				else if (Data_from_BUS == 16'b0000000000000000)
					nzpvalue <= 3'b010;
				else
					nzpvalue <= 3'b001;
			end
	end
	
endmodule 