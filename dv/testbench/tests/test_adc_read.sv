class test_adc_read extends base_test;
  `uvm_component_utils(test_adc_read)
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    i2c_basic_seq seq;
    int expected_value;
    
    phase.raise_objection(this);
    `uvm_info(get_name(), "  ** TEST **", UVM_LOW)

    seq = i2c_basic_seq::type_id::create("seq");
    
    wait_reset();
    #1us;
    
    env.dut_vif.v_ref = 5.0;
    env.dut_vif.v = 1.5;					//input voltage
    
    expected_value = $rtoi($ceil(255.0 / (env.dut_vif.v_ref / env.dut_vif.v)));
    
    seq.i2c_addr = 6;
    seq.i2c_data = 'h01;				//Enable ADC and filters
    seq.i2c_read = 0;
    seq.start(env.i2c_agt.m_sequencer);
    
    if($test$plusargs("ADC_DELAY")) begin
      #100us;
    end else begin
      #20us;
    end
    
    seq.i2c_addr = 7;
    seq.i2c_read = 1;					//Read filtered output
    seq.start(env.i2c_agt.m_sequencer);
    #2us;
     
    //$display("data: %h", env.i2c_agt.monitor.data);
    
    assert(expected_value == env.i2c_agt.monitor.data)
    else `uvm_warning(get_name(), $sformatf("read %h, expected_value %h", seq.i2c_data, expected_value));
    
 	phase.drop_objection(this);
  endtask
endclass : test_adc_read
