`ifndef _CLK_DRV
`define _CLK_DRV

class clk_driver extends uvm_driver;

  `uvm_component_utils(clk_driver)

  virtual dut_if dut_vif;
  clk_cfg cfg;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    assert(uvm_config_db#(virtual dut_if)::get(this, "", "dut_if", dut_vif));
  endfunction

  task run_phase(uvm_phase phase);
    static int i = 0;
    fork
      forever begin
        dut_vif.clk = 1;
        #(cfg.period_high_ns * 1ns);
        dut_vif.clk = 0;
        #(cfg.period_low_ns * 1ns);

        i++;
        /*if((cfg.maximum_cycles > 0) &&
           (i >= cfg.maximum_cycles)) begin
          break;
          $finish("agent_clk: timeout");
        end*/
      end
    join_none;
  endtask
endclass: clk_driver

`endif // _CLK_DRV
