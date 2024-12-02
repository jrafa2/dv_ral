class reset_sequencer extends uvm_sequencer#(reset_basic_tr);
    `uvm_component_utils(reset_sequencer)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

endclass : reset_sequencer
