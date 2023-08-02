module register(input Clk, Reset,Load, input [15:0] D,output logic [15:0] out);
logic [15:0] memory;
	 always_ff @ (posedge Clk)
    begin
	 	 out <= memory;
    end
	 always_comb
	 begin 
		  memory=out;
        if (~Reset)
            memory=16'h00;
        else if (Load)
            memory=D;
    end
endmodule 