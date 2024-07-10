class riscv_environment extends uvm_env;
  `uvm_component_utils(riscv_environment)
  riscv_agent rv_agnt;
  riscv_scoreboard rv_sb;
  function new(string name, uvm_component parent);
  	super.new(name, parent);
  endfunction : new
  
  function void build_phase(uvm_phase phase);
	rv_agnt = riscv_agent::type_id::create("rv_agnt",this);	
	rv_sb = riscv_scoreboard::type_id::create("rv_sb",this);	
  endfunction : build_phase
  
endclass : riscv_environment
