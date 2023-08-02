module datapath (
	input Clk,Reset,
	input GateMARMUX,GateMDR,GateALU,GatePC,MIO_EN,
	input LD_IR,LD_MAR,LD_MDR,LD_PC,LD_CC,LD_BEN,LD_LED,LD_REG,
	input SR1MUX,SR2MUX,DRMUX,ADDR1MUX,
	input[1:0] PCMUX,ADDR2MUX,ALUK,
    input[15:0] MDR_In,
	output logic BEN,
    output logic[15:0] PC,IR,MAR,Data_from_BUS,MDR,//LED????
	 output logic [11:0] LED
);

logic[15:0] PC_In,PC_plus,ADDR_add,ADDR1,ADDR2,ALU_out,MDR_load,SR1_out,SR2_out;
logic[15:0] SEXT_IR4,SEXT_IR5,SEXT_IR8,SEXT_IR10,B;
logic[2:0] SR1,SR2,DR,nzpvalue;
logic[3:0] gate_control;
assign gate_control={GateMARMUX,GateMDR,GateALU,GatePC};
always_comb begin: BUS
	case(gate_control)
		4'b0001:Data_from_BUS = PC;
		4'b0010:Data_from_BUS = ALU_out;
		4'b0100:Data_from_BUS = MDR;
		4'b1000:Data_from_BUS = ADDR_add;
		default:Data_from_BUS = 16'h0;
	endcase
end

always_comb begin: SEXT
	if(IR[5]==0)
		SEXT_IR5={{10{1'b0}},IR[5:0]};
	else
		SEXT_IR5={{10{1'b1}},IR[5:0]};
	if(IR[8]==0)
		SEXT_IR8={{7{1'b0}},IR[8:0]};
	else
		SEXT_IR8={{7{1'b1}},IR[8:0]};
	if(IR[10]==0)
		SEXT_IR10={{5{1'b0}},IR[10:0]};
	else
		SEXT_IR10={{5{1'b1}},IR[10:0]};
	if(IR[4]==0)
		SEXT_IR4={{11{1'b0}},IR[4:0]};
	else
		SEXT_IR4={{11{1'b1}},IR[4:0]};
end


always_comb begin : OTHER
	
	ADDR_add=ADDR1+ADDR2;   //This is the address adder
	PC_plus=PC+1;			//This is the PC incrementation	
	if (IR[15:12]==4'b0001 || IR[15:12]==4'b0101)
		SR2=IR[2:0];
	else
		SR2=3'b000;

end


//This is the alu unit
ALU alu(.ALUK(ALUK),.A(SR1_out),.B(B),.S(ALU_out));
mux2_1_16bits mdrmux(.A(Data_from_BUS), .B(MDR_In), .select(MIO_EN), .Out(MDR_load) );
//This is the list of registers
register ir(.Clk(Clk),.Reset(Reset),.Load(LD_IR),.D(Data_from_BUS),.out(IR));
register mar(.Clk(Clk),.Reset(Reset),.Load(LD_MAR),.D(Data_from_BUS),.out(MAR));
register mdr(.Clk(Clk),.Reset(Reset),.Load(LD_MDR),.D(MDR_load),.out(MDR));
register pc(.Clk(Clk),.Reset(Reset),.Load(LD_PC),.D(PC_In),.out(PC));
register_file rf(.Clk(Clk),.Reset(Reset),.LD_REG(LD_REG),.DR(DR),.D(Data_from_BUS),.SR1(SR1),.SR2(SR2),.SR1_out(SR1_out),.SR2_out(SR2_out));
// BEN_M ben(.Data_from_BUS(Data_from_BUS),.LD_CC(LD_CC),.LD_BEN(LD_BEN),.Clk(Clk),.Reset(~Reset),.IR(IR),.BEN(BEN));
BEN_M ben(.*);
CC cc(.*);
//This is the list of mux
mux3_1 pcmux(.A0(PC_plus),.A1(Data_from_BUS),.A2(ADDR_add),.select(PCMUX),.out(PC_In));
mux2_1_16bits addr1mux(.A(PC), .B(SR1_out), .select(ADDR1MUX), .Out(ADDR1));
mux4_1 addr2mux(.A0(16'b0),.A1(SEXT_IR5),.A2(SEXT_IR8),.A3(SEXT_IR10),.select(ADDR2MUX),.out(ADDR2));
mux2_1 sr1mux(.A(IR[11:9]),.B(IR[8:6]),.select(SR1MUX),.Out(SR1));
mux2_1_16bits sr2mux(.A(SR2_out),.B(SEXT_IR4),.select(SR2MUX),.Out(B));
mux2_1 drmux(.A(IR[11:9]),.B(3'b111),.select(DRMUX),.Out(DR));


//This is MIO.EN and R.W
always_ff @ (posedge Clk)
	begin
		if (LD_LED) 
			LED <= IR[11:0];
		else if (~Reset)
			LED <= 12'b000000000000;
		
	end
endmodule
