// -*- Verilog -*-
// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2019 by Wilson Snyder.

// All the heavy lifting needed here
`include "submodules/uvm/src/uvm_pkg.sv"

module t (/*AUTOARG*/);
   initial begin
      $write("Hello World\n");
      $write("*-* All Finished *-*\n");
      $finish;
   end
endmodule
