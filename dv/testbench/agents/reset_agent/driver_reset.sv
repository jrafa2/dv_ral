`ifndef _RST_DRV
`define _RST_DRV

class rst_driver extends uvm_driver #(reset_basic_tr);
  `uvm_component_utils(rst_driver)

  virtual dut_if dut_vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
  endfunction : build_phase

  function void connect_phase(uvm_phase phase);
    assert(uvm_config_db#(virtual dut_if)::get(this, "", "dut_if", dut_vif));
  endfunction

  task run_phase(uvm_phase phase);
    fork
      forever begin
        seq_item_port.get_next_item(req);

        dut_vif.reset_n = req.value;

        seq_item_port.item_done();
      end
    join_none;
  endtask
endclass: rst_driver

`endif // _RST_DRV
