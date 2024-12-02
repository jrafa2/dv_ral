`ifndef _RST_AGT
`define _RST_AGT

`include "driver_reset.sv"

class rst_agent extends uvm_agent;
  `uvm_component_utils(rst_agent)

  rst_driver rst_drv;
  reset_sequencer m_sequencer;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    rst_drv = rst_driver::type_id::create("rst_drv", this);
    m_sequencer = reset_sequencer::type_id::create("m_sequencer", this);
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    rst_drv.seq_item_port.connect(m_sequencer.seq_item_export);
  endfunction : run_phase
endclass : rst_agent

`endif // _RST_AGT
