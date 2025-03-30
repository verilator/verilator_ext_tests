// DESCRIPTION: Verilator: Verilog Test module
//
// This file ONLY is placed under the Creative Commons Public Domain, for
// any use, without warranty, 2009 by Wilson Snyder.
// SPDX-License-Identifier: CC0-1.0

`define STRINGIFY(x) `"x`"

typedef enum logic [1:0] {VAL_A, VAL_B, VAL_C, VAL_D} state_t;

interface MyIntf;
   state_t state;
endinterface

module t;
   logic clk;
   initial forever begin
      clk = 1;
      #5;
      clk = 0;
      #5;
   end

   MyIntf #() sink ();
   state_t v_enumed;

   typedef enum logic [1:0] {VAL_X, VAL_Y, VAL_Z} other_state_t;
   other_state_t v_other_enumed;

   initial begin
      $dumpfile(`STRINGIFY(`TEST_DUMPFILE));
      $dumpvars();
      #100;
      $write("*-* All Finished *-*\n");
      $finish;
   end

endmodule
