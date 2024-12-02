`ifndef _RST_SEQ
`define _RST_SEQ

`include "transaction_reset.sv"

class reset_basic_seq extends uvm_sequence#(reset_basic_tr);
  `uvm_object_utils(reset_basic_seq)

  byte value;  //line value

  function new(string name = "reset_basic_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_type_name(), "reset_basic_seq created", UVM_LOW)
    `uvm_do_with(req, { req.value == value; });
  endtask : body
endclass : i2c_basic_seq

class reset_random_seq extends uvm_sequence#(reset_basic_tr);
  `uvm_object_utils(reset_random_seq)

  function new(string name = "reset_random_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_info(get_type_name(), "reset_random_seq created", UVM_LOW)
    `uvm_do(req);
  endtask : body
endclass : reset_random_seq

class reset_cycle_seq extends uvm_sequence#(reset_basic_tr);
  `uvm_object_utils(reset_cycle_seq)

    int reset_time_us;

  function new(string name = "reset_cycle_seq");
    super.new(name);
  endfunction

  virtual task body();
    `uvm_do_with(req, { req.value == 0; });
    #(reset_time_us * 1us);
    `uvm_do_with(req, { req.value == 1; });
  endtask : body
endclass : reset_cycle_seq

`endif // _RST_SEQ
