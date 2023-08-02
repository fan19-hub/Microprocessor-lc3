module ALU (
    input[1:0] ALUK,
    input[15:0] A,B,
    output logic[15:0] S
);


always_comb begin : SELECT  

case (ALUK)
    2'b00:S=A+B;
    2'b01:S=A&B;
    2'b10:S=~A;
    2'b11:S=A;
    default: S=A; 
endcase

end

endmodule