class riscv_transaction extends uvm_sequence_item;

	
	rand reg reset;
	typedef reg [31:0] Raddr;
	typedef reg signed [31:0] Rdata;
    	//Rdata memory[Raddr];
    	Rdata dut_mem[Raddr];
	Rdata finishedcode;
	
	rand reg[11:0] imm_field;
	rand reg[4:0] rs1;
	rand reg[2:0] funct;
	rand reg[4:0] rd;
	rand reg[6:0] opcode;
	rand reg inst_wr;
	rand reg[31:0] mem_addr;
	rand reg[31:0] mem_data;
	rand reg[31:0] dut_mem_addr;
    	Rdata dut_mem_data[Raddr];
    	
    	rand reg[11:0] s_imm_field;
    	rand reg[4:0] s_rs2;
    	rand reg[4:0] s_rs1;
    	rand reg[2:0] funct;
    	rand reg[6:0] s_opcode;
	

endclass
