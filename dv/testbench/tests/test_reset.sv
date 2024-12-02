class test_reset extends base_test;
  `uvm_component_utils(test_reset)

  rand int repetitions;
  constraint repetitions_c{
    repetitions > 0;
    repetitions < 10;
  }

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    uvm_status_e status;
    uvm_reg_data_t data_read;

    assert(this.randomize);
    `uvm_info(get_name(), "  ** TEST **", UVM_LOW)
    `uvm_info(get_name(), $sformatf("repetitions: %0d", repetitions), UVM_LOW)

    phase.raise_objection(this);
    wait_reset();

    repeat(2/*repetitions*/) begin
       #($urandom_range(30, 5) * 1us);   //random delay
       reset();
       wait_reset();

       //check it is still asive
       env.regmap.chip_id_reg.read(status, data_read);
       assert(8'hA5 === data_read)
       else `uvm_warning(get_name(), $sformatf("data read: %h", data_read))
    end

    phase.drop_objection(this);
  endtask
endclass : test_reset
