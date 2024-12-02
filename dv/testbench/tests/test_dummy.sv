class test_dummy extends base_test;
  `uvm_component_utils(test_dummy)

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    #2us;

    phase.drop_objection(this);
  endtask
endclass : test_dummy
