class test_cic extends base_test;
  `uvm_component_utils(test_cic)

  rand int cic_factor;
  constraint cic_factor_c{
    cic_factor >= 0;
    cic_factor <= 3;
  }

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    real y[];
    python_fir fir;
    i2c_basic_seq seq;
    int expected_value;
    uvm_hdl_data_t read_value;
    int wait_time_us;

    super.run_phase(phase);

    assert(this.randomize);

    phase.raise_objection(this);

    `uvm_info(get_name(), "  ** TEST **", UVM_LOW)
    `uvm_info(get_name(), $sformatf("cic_factor: %0d", cic_factor), UVM_LOW)

    unique case(cic_factor)
        0: wait_time_us = 30;
        1: wait_time_us = 50;
        2: wait_time_us = 70;
        3: wait_time_us = 100;
    endcase

    seq = i2c_basic_seq::type_id::create("seq");

    env.dut_vif.v_ref = 5.0;
    env.dut_vif.v = 1.5;    //input voltage

    expected_value = $rtoi($ceil(255.0 / (env.dut_vif.v_ref / env.dut_vif.v)));

    seq.i2c_addr = 4;
    seq.i2c_data = cic_factor;    //CIC
    seq.i2c_read = 0;
    seq.start(env.i2c_agt.m_sequencer);

    seq.i2c_addr = 6;
    seq.i2c_data = 'h01;    //Enable ADC and filters
    seq.i2c_read = 0;
    seq.start(env.i2c_agt.m_sequencer);

    #(wait_time_us*1us);

    env.dut_vif.v = 0;    //input voltage
    #(wait_time_us*1us);
    expected_value = $rtoi($ceil(255.0 / (env.dut_vif.v_ref / env.dut_vif.v)));
    uvm_hdl_read("top.dut.u_datapath.cic_u.data_out", read_value);
    assert(expected_value == read_value)
    else `uvm_warning(get_name(), $sformatf("expected_value %0d, read_value %0d", expected_value, read_value))

    env.dut_vif.v = 2.49;    //input voltage
    #(wait_time_us*1us);
    expected_value = $rtoi($ceil(255.0 / (env.dut_vif.v_ref / env.dut_vif.v)));
    uvm_hdl_read("top.dut.u_datapath.cic_u.data_out", read_value);
    assert(expected_value == read_value)
    else `uvm_warning(get_name(), $sformatf("expected_value %0d, read_value %0d", expected_value, read_value))

    env.dut_vif.v = 0;    //input voltage
    #(wait_time_us*1us);
    expected_value = $rtoi($ceil(255.0 / (env.dut_vif.v_ref / env.dut_vif.v)));
    uvm_hdl_read("top.dut.u_datapath.cic_u.data_out", read_value);
    assert(expected_value == read_value)
    else `uvm_warning(get_name(), $sformatf("expected_value %0d, read_value %0d", expected_value, read_value))

    env.dut_vif.v = 1.5;    //input voltage
    #(wait_time_us*1us);
    expected_value = $rtoi($ceil(255.0 / (env.dut_vif.v_ref / env.dut_vif.v)));
    uvm_hdl_read("top.dut.u_datapath.cic_u.data_out", read_value);
    assert(expected_value == read_value)
    else `uvm_warning(get_name(), $sformatf("expected_value %0d, read_value %0d", expected_value, read_value))

    //expected value (calculated with python)
    /*fir = new();
    y = fir.filter(.coefs('{0.5, 0.5}), .signal('{0.5, 0.5}));

    `uvm_info(get_name(), $sformatf("Expected values: %p", y), UVM_LOW);*/

    phase.drop_objection(this);
  endtask
endclass : test_cic
