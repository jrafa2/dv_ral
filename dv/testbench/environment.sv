`include "package_i2c.sv"
`include "package_clk.sv"
`include "package_reset.sv"
`include "utils/python_fir.sv"

import i2c_pkg::*;
import clk_pkg::*;
import rst_pkg::*;

class environment extends uvm_env;
  `uvm_component_utils(environment)

  i2c_agent i2c_agt;
  clk_agent clk_agt;
  rst_agent rst_agt;

  virtual dut_if dut_vif;

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    i2c_agt = i2c_agent::type_id::create("i2c_agt", this);
    clk_agt = clk_agent::type_id::create("clk_agt", this);
    rst_agt = rst_agent::type_id::create("rst_agt", this);
  endfunction

  function void connect_phase(uvm_phase phase);
    assert(uvm_config_db#(virtual dut_if)::get(this, "", "dut_if", dut_vif));  

//    `include "regs/ral_backdoor.sv"
  endfunction
endclass : environment
