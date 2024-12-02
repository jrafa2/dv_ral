class test_i2c_read extends base_test;
  `uvm_component_utils(test_i2c_read)

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    i2c_basic_seq seq;

    phase.raise_objection(this);
    `uvm_info(get_name(), "  ** TEST **", UVM_LOW)

    seq = i2c_basic_seq::type_id::create("seq");

    wait_reset();
    #1us;

    seq.i2c_addr = 4;
    seq.i2c_read = 1;
    seq.start(env.i2c_agt.m_sequencer);
    #2us;

//    assert('h01 === seq.i2c_data)
//    else `uvm_warning(get_name(), $sformatf("data read: %h", seq.i2c_data))

  phase.drop_objection(this);
  endtask
endclass : test_i2c_read
