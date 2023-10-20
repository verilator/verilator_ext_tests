// -*- Verilog -*-
// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed under the Creative Commons Public Domain, for
// any use, without warranty, 2019 by Wilson Snyder.
// SPDX-License-Identifier: CC0-1.0

`define UVM_NO_DPI

// All the heavy lifting needed here
`include "uvm_pkg.sv"

module t (/*AUTOARG*/);
   initial begin
      $write("Hello World\n");
      $write("*-* All Finished *-*\n");
      $finish;
   end
endmodule
