`ifndef _RST_TR
`define _RST_TR

class reset_basic_tr extends uvm_sequence_item;
  rand bit value;
  time t;                 //debug info

  `uvm_object_utils_begin(reset_basic_tr)
    `uvm_field_int(value, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "");
    super.new(name);
    t = $realtime;
  endfunction

endclass : reset_basic_tr

`endif // _RST_TR
