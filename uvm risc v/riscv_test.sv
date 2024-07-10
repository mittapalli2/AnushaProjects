class riscv_test extends uvm_test;
	`uvm_component_utils(riscv_test)
	
	riscv_environment rv_env;
	riscv_sequence rv_seq;
	
	function new(string name = "riscv_test",uvm_component parent = "null");
		super.new(name,parent);
	endfunction : new
	
	function void build_phase(uvm_phase phase);
		rv_env = riscv_environment::type_id::create("rv_e",this);
		rv_seq = riscv_sequence::type_id::create("rv_seq");
	endfunction
	
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		$display("Raise objection is made");
		rv_seq.start(rv_env.rv_agnt.rv_seqr);
		#605;
		phase.drop_objection(this);
		$display("drop objection is made");
	endtask : run_phase
	
endclass : riscv_test
