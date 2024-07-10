class riscv_scoreboard extends uvm_scoreboard;
`uvm_component_utils(riscv_scoreboard)

riscv_transaction rv_trs;
  int i = 0;
function new(string name = "riscv_scoreboard", uvm_component parent);
	super.new(name,parent);
	rv_trs = new();
endfunction : new

virtual task run_phase(uvm_phase phase);
	forever begin
	#604;
	foreach(mem_ref[i]) begin
			if (mem_ref[i] !== (mem[i])) `uvm_error("SCB",$sformatf("Data Mismatch memory is: %0x data is: %0x at address %0x",mem_ref[i],mem[i],i));
		end
	end
endtask


endclass : riscv_scoreboard
