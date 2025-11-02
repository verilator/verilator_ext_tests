// -*- Verilog -*-
// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed under the Creative Commons Public Domain, for
// any use, without warranty, 2019 by Wilson Snyder.
// SPDX-License-Identifier: CC0-1.0

// All the heavy lifting needed here
`include "uvm_pkg.sv"

// verilator lint_off DECLFILENAME

module t;
  import uvm_pkg::*;
  initial begin
    // verilator lint_off WIDTHTRUNC
    `uvm_info("TOP", "Hello World!", UVM_MEDIUM);
  end
endmodule
