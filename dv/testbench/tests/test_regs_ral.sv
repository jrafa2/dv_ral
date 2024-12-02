class test_regs_ral extends base_test;
   
  `uvm_component_utils(test_regs_ral)
  
  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    uvm_status_e status;
    uvm_reg_data_t data_write;
    uvm_reg_data_t data_read;

    phase.raise_objection(this);
    `uvm_info(get_name(), "  ** TEST **", UVM_LOW)

    wait_reset();
    #1us;

    //Frontdoor
    data_write = $urandom_range(255, 0);
    env.regmap.fir_coef_2_reg.write(status, data_write);
    env.regmap.fir_coef_2_reg.read(status, data_read);
    #20us;

    assert(data_write == data_read)
    else `uvm_warning(get_name(), $sformatf("data_write %d, data_read %d", data_write, data_read))

    //Backdoor
    env.regmap.fir_coef_2_reg.peek(status, data_read);

    assert(data_write == data_read)
    else `uvm_warning(get_name(), $sformatf("data_write %d, data_read %d", data_write, data_read))

 	  phase.drop_objection(this);
    `uvm_info(get_name(), "  ** END TEST **", UVM_LOW)
  endtask
endclass : test_regs_ral
