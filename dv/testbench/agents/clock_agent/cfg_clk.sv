`ifndef _CLK_CFG
`define _CLK_CFG

class clk_cfg extends uvm_object;
  int unsigned period_high_ns = 1000;
  int unsigned period_low_ns = 1000;
  int maximum_cycles = 10;   //-1 forever

  `uvm_object_utils_begin(clk_cfg)
    `uvm_field_int(period_high_ns, UVM_DEFAULT)
    `uvm_field_int(period_low_ns, UVM_DEFAULT)
    `uvm_field_int(maximum_cycles, UVM_DEFAULT)
  `uvm_object_utils_end

  function new(string name = "clk_cfg");
    super.new(name);
  endfunction : new
  
endclass : clk_cfg

`endif // _CLK_CFG
