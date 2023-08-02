module mux2_1(input [2:0]A, B, input select, output logic [2:0]Out);
always_comb
	begin
		if(select == 1'b0)
			Out = A;
		else
			Out = B;
	end
endmodule 

