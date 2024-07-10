class riscv_driver extends uvm_driver#(riscv_transaction);
//`include "remul.sv"
	int raddr;
	int finished_code=0;
	`uvm_component_utils(riscv_driver)
	function new(string name = "riscv_driver",uvm_component parent = null);
		super.new(name,parent);
	endfunction : new
	
	virtual task run_phase(uvm_phase phase);
		riscv_transaction rv_si;
    		forever begin
        		seq_item_port.get_next_item(rv_si);
        			`uvm_info("Driver",$sformatf("PC = %0x data: =%0x ",rv_si.mem_addr,rv_si.mem_data),UVM_MEDIUM)
        			reset=rv_si.reset;
        			//rv_si.memory[rv_si.mem_addr] = rv_si.mem_data;// for my ref
        			mem_ref[rv_si.mem_addr] = rv_si.mem_data;
        			mem[rv_si.mem_addr] = rv_si.mem_data;
        			//$display("dut %0x ref %0x",mem[rv_si.mem_addr],mem_ref[rv_si.mem_addr]);
        			//$display("finished code = %h",finishedcode);
        			if(rv_si.inst_wr == 1'b1) REMUL_REF();
        			if(rv_si.inst_wr == 1'b1) REMUL();
        		seq_item_port.item_done(rv_si);
        	end
        endtask : run_phase

endclass : riscv_driver
