import uvm_pkg::*;
`include "riscv_pkg.sv"
import riscv_pkg::*;

module top;
reg reset;

initial begin
	$display("riscv test bench top is running");
	run_test("riscv_test");
end

initial begin
	$dumpfile("dump.vcd");
	$dumpvars;
end
endmodule : top
