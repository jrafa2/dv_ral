`include "environment.sv"

class base_test extends uvm_test;

  environment env;

  `uvm_component_utils(base_test)

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    env = environment::type_id::create("env", this);
  endfunction

  task wait_reset();
    wait(env.dut_vif.reset_n == 1);
  endtask : wait_reset

  task reset(int reset_time_us = 10);
    reset_cycle_seq seq = reset_cycle_seq::type_id::create("seq");
    seq.reset_time_us = reset_time_us;
    seq.start(env.rst_agt.m_sequencer);
  endtask : reset
endclass
