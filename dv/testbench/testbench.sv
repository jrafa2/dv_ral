import uvm_pkg::*;
`include "uvm_macros.svh"
import regs::*;

`include "dut_if.sv"
`include "lib_test.sv"
`include "adc_dms_model.sv"

module top;
  dut_if dut_if();

  digital_top dut(
    .clk(dut_if.clk), 
    .reset_n(dut_if.reset_n), 
    
    .sclk(dut_if.sclk), 
    .sdata(dut_if.sdata),
  
    .adc_convert(dut_if.adc_convert),
    .adc_ready(dut_if.adc_ready),
    .adc_q(dut_if.adc_q)
  );

  adc_dms_model adc(
    .clk(dut_if.clk),
    .rst_n(dut_if.reset_n),
    .v_in(dut_if.v),
    .v_ref(dut_if.v_ref),
    
    .enable(dut_if.adc_convert),
    .data_ready(dut_if.adc_ready),
    .adc_q(dut_if.adc_q)
  );

  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    $shm_open("waves.shm");
    $shm_probe("ASM");
    dut_if.reset_n <= 0;
    #10us;
    dut_if.reset_n <= 1;
  end

  initial begin
    uvm_config_db#(virtual dut_if)::set(null, "*", "dut_if", dut_if);
    run_test(); //+UVM_TESTNAME=test_i2c_write
  end

endmodule : top
