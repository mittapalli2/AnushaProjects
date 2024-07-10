int dest_source;
class riscv_sequence extends uvm_sequence#(riscv_transaction);
	`uvm_object_utils(riscv_sequence)
	logic [31:0] pc_rv=32'hE000_0000;
	logic [31:0] pc_1=32'h0000_0001;
	int opcode_addr = 32'h8000_0000;
	function new(string name = "riscv_sequence");
		super.new(name);
	endfunction
	
	task body();
		riscv_transaction rv_si;
		rv_si = new();
		repeat(4095) begin
			start_item(rv_si);
			//$display("Generating the sequence logic goes here");
			rv_si.randomize() with {rv_si.opcode == 7'b0010100;rv_si.mem_addr ==pc_1;rv_si.funct ==3'b000;rv_si.reset == 1'b0;rv_si.inst_wr == 1'b0;};
			pc_1 +=1;
			finish_item(rv_si);
			get_response(rv_si);
		end
		repeat(2) begin
			start_item(rv_si);
			//$display("Generating the sequence logic goes here");
			rv_si.randomize() with {rv_si.opcode == 7'b0010100;rv_si.mem_addr ==32'h8000_0018;rv_si.funct ==3'b000;rv_si.reset == 1'b0;rv_si.inst_wr == 1'b0;};
			rv_si.mem_data = 1;
			finish_item(rv_si);
			get_response(rv_si);
		end
		repeat(1) begin
			start_item(rv_si);
			//$display("Generating the sequence for reset");
			rv_si.randomize() with {rv_si.reset == 1'b1;rv_si.inst_wr == 1'b1;};
			finish_item(rv_si);
			get_response(rv_si);
			//REMUL();
		end
		repeat(1) begin
			start_item(rv_si);
				//$display("Generating the sequence logic goes here");
				rv_si.randomize() with {rv_si.opcode == 7'b0000011;rv_si.funct ==3'b000;rv_si.mem_addr ==opcode_addr;rv_si.reset == 1'b0;rv_si.inst_wr == 1'b1;rv_si.imm_field[11]==0;};
				rv_si.mem_data = {rv_si.imm_field,rv_si.rs1,rv_si.funct,rv_si.rd,rv_si.opcode};
				//$display(rv_si.rs1);
				opcode_addr=opcode_addr+4;
				dest_source = rv_si.rd;
			finish_item(rv_si);
			get_response(rv_si);
			start_item(rv_si);
				rv_si.randomize() with {rv_si.s_opcode == 7'b0100011;rv_si.funct ==3'b000;rv_si.mem_addr ==opcode_addr;rv_si.reset == 1'b0;rv_si.s_rs2 == dest_source;rv_si.inst_wr == 1'b1;rv_si.s_imm_field[11]==0;};
				rv_si.mem_data = {rv_si.s_imm_field[11:5],rv_si.s_rs2,rv_si.s_rs1,rv_si.funct,rv_si.s_imm_field[4:0],rv_si.s_opcode};
				//$display(rv_si.s_rs1);
				opcode_addr=opcode_addr+4;
			finish_item(rv_si);
			get_response(rv_si);
		end
		repeat(1) begin
			start_item(rv_si);
				//$display("Generating the sequence logic goes here");
				rv_si.randomize() with {rv_si.opcode == 7'b0000011;rv_si.funct ==3'b001;rv_si.mem_addr ==opcode_addr;rv_si.reset == 1'b0;rv_si.inst_wr == 1'b1;rv_si.imm_field[11]==0;};
				rv_si.mem_data = {rv_si.imm_field,rv_si.rs1,rv_si.funct,rv_si.rd,rv_si.opcode};
				opcode_addr=opcode_addr+4;
				dest_source = rv_si.rd;
			finish_item(rv_si);
			get_response(rv_si);
			start_item(rv_si);
				rv_si.randomize() with {rv_si.s_opcode == 7'b0100011;rv_si.funct ==3'b001;rv_si.mem_addr ==opcode_addr;rv_si.reset == 1'b0;rv_si.s_rs2 == dest_source;rv_si.inst_wr == 1'b1;rv_si.s_imm_field[11]==0;};
				rv_si.mem_data = {rv_si.s_imm_field[11:5],rv_si.s_rs2,rv_si.s_rs1,rv_si.funct,rv_si.s_imm_field[4:0],rv_si.s_opcode};
				opcode_addr=opcode_addr+4;
			finish_item(rv_si);
			get_response(rv_si);
		end
		repeat(1) begin
			start_item(rv_si);
				//$display("Generating the sequence logic goes here");
				rv_si.randomize() with {rv_si.opcode == 7'b0000011;rv_si.funct ==3'b010;rv_si.mem_addr ==opcode_addr;rv_si.reset == 1'b0;rv_si.inst_wr == 1'b1;rv_si.imm_field[11]==0;};
				rv_si.mem_data = {rv_si.imm_field,rv_si.rs1,rv_si.funct,rv_si.rd,rv_si.opcode};
				opcode_addr=opcode_addr+4;
				dest_source = rv_si.rd;
			finish_item(rv_si);
			get_response(rv_si);
			start_item(rv_si);
				rv_si.randomize() with {rv_si.s_opcode == 7'b0100011;rv_si.funct ==3'b010;rv_si.mem_addr ==opcode_addr;rv_si.reset == 1'b0;rv_si.s_rs2 == dest_source;rv_si.inst_wr == 1'b1;rv_si.s_imm_field[11]==0;};
				rv_si.mem_data = {rv_si.s_imm_field[11:5],rv_si.s_rs2,rv_si.s_rs1,rv_si.funct,rv_si.s_imm_field[4:0],rv_si.s_opcode};
				opcode_addr=opcode_addr+4;
			finish_item(rv_si);
			get_response(rv_si);
		end
		repeat(1) begin
			start_item(rv_si);
				rv_si.randomize() with {rv_si.s_opcode == 7'b0100011;rv_si.funct ==3'b000;rv_si.mem_addr ==opcode_addr;rv_si.reset == 1'b0;rv_si.s_rs2 == dest_source;rv_si.inst_wr == 1'b1;rv_si.s_imm_field[11]==0;};
				rv_si.mem_data = {rv_si.s_imm_field[11:5],rv_si.s_rs2,rv_si.s_rs1,rv_si.funct,rv_si.s_imm_field[4:0],rv_si.s_opcode};
				opcode_addr=opcode_addr+4;
			finish_item(rv_si);
			get_response(rv_si);
		end
		
	endtask : body


endclass : riscv_sequence
