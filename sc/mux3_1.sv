module mux3_1(input [15:0] A0,A1,A2, input [1:0]select, output logic [15:0]out);
	always_comb 
	begin
		if (select==2'b00)
			out=A0;
		else if(select==2'b01)
			out=A1;
		else  out=A2;
	end
 endmodule
  
