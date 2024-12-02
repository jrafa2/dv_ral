`ifndef _I2C_TR
`define _I2C_TR

class i2c_basic_tr extends uvm_sequence_item;
  byte device_addr = 1;
  rand byte addr;         //register address
  rand logic[7:0] data;   //register value
  rand byte read=0;       //1: read; 0: write
  time t;                 //debug info

  `uvm_object_utils_begin(i2c_basic_tr)
    `uvm_field_int(device_addr, UVM_ALL_ON)
    `uvm_field_int(addr, UVM_ALL_ON)
    `uvm_field_int(data, UVM_ALL_ON)
    `uvm_field_int(read, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "");
    super.new(name);
    t = $realtime;
  endfunction

endclass : i2c_basic_tr

`endif // _I2C_TR
