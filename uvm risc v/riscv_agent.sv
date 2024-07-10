class riscv_agent extends uvm_agent;
	`uvm_component_utils(riscv_agent)
	
	riscv_sequencer rv_seqr;
	riscv_driver rv_drv;
	
	function new(string name = "riscv_agnet", uvm_component parent = null);
		super.new(name,parent);
	endfunction : new
	
	function void build_phase(uvm_phase phase);
		rv_seqr = riscv_sequencer::type_id::create("rv_seqr",this);
		rv_drv = riscv_driver::type_id::create("rv_drv",this);
	endfunction : build_phase
	
	function void connect_phase(uvm_phase phase);
		rv_drv.seq_item_port.connect(rv_seqr.seq_item_export);
	endfunction : connect_phase

endclass : riscv_agent
