`ifndef _CLK_AGT
`define _CLK_AGT

class clk_agent extends uvm_agent;
  `uvm_component_utils(clk_agent)

  clk_driver clk_drv;
  clk_cfg clk_config;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    clk_drv = clk_driver::type_id::create("clk_drv", this);
    clk_config = clk_cfg::type_id::create("clk_config", this);
    clk_drv.cfg = clk_config;
  endfunction : build_phase

  task run_phase(uvm_phase phase);
  endtask : run_phase
endclass : clk_agent

`endif // _CLK_AGT
