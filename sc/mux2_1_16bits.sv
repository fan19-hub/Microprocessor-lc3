module mux2_1_16bits(input [15:0]A, B, input select, output logic [15:0]Out);
always_comb
	begin
		if(select == 1'b0)
			Out = A;
		else
			Out = B;
	end
endmodule 