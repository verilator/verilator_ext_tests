// -*- Verilog -*-
// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2019 by Wilson Snyder.

// Since Verilator doesn't yet have these standard packages, we hack around that
class process;
endclass
class mailbox;
endclass
class semaphore;
endclass

// All the heavy lifting needed here
`include "submodules/uvm/src/uvm_pkg.sv"

module t (/*AUTOARG*/);
   initial begin
      $write("Hello World\n");
      $write("*-* All Finished *-*\n");
      $finish;
   end
endmodule
