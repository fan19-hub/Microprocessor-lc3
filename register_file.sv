module register_file (
    input Clk,Reset,LD_REG,
    input[15:0] D,
    input[2:0] SR1,SR2,DR,
    // output logic,
    output logic[15:0] SR1_out,SR2_out
);
logic[3:0]  load;
logic[7:0] LD_R;
logic[15:0] R0_out,R1_out,R2_out,R3_out,R4_out,R5_out,R6_out,R7_out;
register r0(.Clk(Clk),.Reset(Reset),.Load(LD_R[0]),.D(D),.out(R0_out));
register r1(.Clk(Clk),.Reset(Reset),.Load(LD_R[1]),.D(D),.out(R1_out));
register r2(.Clk(Clk),.Reset(Reset),.Load(LD_R[2]),.D(D),.out(R2_out));
register r3(.Clk(Clk),.Reset(Reset),.Load(LD_R[3]),.D(D),.out(R3_out));
register r4(.Clk(Clk),.Reset(Reset),.Load(LD_R[4]),.D(D),.out(R4_out));
register r5(.Clk(Clk),.Reset(Reset),.Load(LD_R[5]),.D(D),.out(R5_out));
register r6(.Clk(Clk),.Reset(Reset),.Load(LD_R[6]),.D(D),.out(R6_out));
register r7(.Clk(Clk),.Reset(Reset),.Load(LD_R[7]),.D(D),.out(R7_out));

always_comb begin : LOAD_DR
load={LD_REG,DR};
case(load)
    4'b1000:
        LD_R=8'b00000001;//0
    4'b1001:
        LD_R=8'b00000010;//1
    4'b1010:
        LD_R=8'b00000100;//2
    4'b1011:
        LD_R=8'b00001000;//3
    4'b1100:
        LD_R=8'b00010000;//4
    4'b1101:
        LD_R=8'b00100000;//5
    4'b1110:
        LD_R=8'b01000000;//6
    4'b1111:
        LD_R=8'b10000000;//7
    default:
        LD_R=8'b00000000;
endcase

end

always_comb begin : READ_SR1_SR2
case(SR1)
    3'b000:
        SR1_out=R0_out;//0
    3'b001:
        SR1_out=R1_out;//1
    3'b010:
        SR1_out=R2_out;//2
    3'b011:
        SR1_out=R3_out;//3
    3'b100:
        SR1_out=R4_out;//4
    3'b101:
        SR1_out=R5_out;//5
    3'b110:
        SR1_out=R6_out;//6
    3'b111:
        SR1_out=R7_out;//7
    default:
        SR1_out=16'b0;
endcase
end

always_comb begin : READ_SR1
case(SR2)
    3'b000:
        SR2_out=R0_out;//0
    3'b001:
        SR2_out=R1_out;//1
    3'b010:
        SR2_out=R2_out;//2
    3'b011:
        SR2_out=R3_out;//3
    3'b100:
        SR2_out=R4_out;//4
    3'b101:
        SR2_out=R5_out;//5
    3'b110:
        SR2_out=R6_out;//6
    3'b111:
        SR2_out=R7_out;//7
    default:
        SR2_out=16'b0;
endcase
end
endmodule