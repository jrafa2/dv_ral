class test_fir extends base_test;
  `uvm_component_utils(test_fir)

  function new(string name, uvm_component parent);
    super.new(name,parent);
  endfunction

  task run_phase(uvm_phase phase);
    real y_expected[];
    real y_read[];
    real x_volts[] = '{0, 1.0, 1.25, 2.25, 2.0, 1.75, 1.25, 0.75, 0.25};
    real x_py[];
    real coefs[3] = '{1.0, 1.0, 0.0};  //be aware of stable filters
    real div = 1;   //exp of 2. Example: 0 --> 2**0=1
    python_fir fir;
    uvm_status_e status;

    phase.raise_objection(this);
    `uvm_info(get_name(), "  ** TEST **", UVM_LOW)

    //RTL actual values
    env.regmap.fir_coef_0_reg.write(status, coefs[0]);
    env.regmap.fir_coef_1_reg.write(status, coefs[1]);
    env.regmap.fir_coef_2_reg.write(status, coefs[2]);
    env.regmap.fir_div_reg.write(status, div);

    env.regmap.control_reg.write(status, 1);
    fork
      monitor_filter(x_volts.size());
      driver_filter(x_volts);
    join_none;
    #200us;

    //expected value (calculated with python)
    x_py = new[x.size()];
    foreach(coefs[i]) coefs[i] /= (2**div);
    foreach(x[i]) x_py[i] = x[i];
    fir = new();
    y_expected = fir.filter(.coefs(coefs), .signal(x_py));

    `uvm_info(get_name(), $sformatf("Expected values: %p", y_expected), UVM_LOW)

$display("x: %p", x);
$display("y: %p", y);
$display("y_expected: %p", y_expected);

    phase.drop_objection(this);
  endtask

  real x[$];
  real y[$];
  task monitor_filter(int data_limit = -1);
    int ready, enable;
    byte signed data_x, data_y;
    fork
      forever begin
        @(posedge env.dut_vif.clk);
        uvm_hdl_read("top.dut.u_datapath.fir_u.enable", enable);
        uvm_hdl_read("top.dut.u_datapath.fir_u.in_ready", ready);
        if(enable && ready) begin
          uvm_hdl_read("top.dut.u_datapath.fir_u.data_in", data_x);
          uvm_hdl_read("top.dut.u_datapath.fir_u.data_out", data_y);
          x.push_back(data_x);
          y.push_back(data_y);

          if(data_limit != -1) begin
            if(x.size() >= data_limit) break;
          end
        end
      end
    join_none;
  endtask : monitor_filter

  task driver_filter(real values[]);
    int i = 0;
    int size = values.size();
    fork
      forever begin
        @(posedge env.dut_vif.clk);
        env.dut_vif.v = values[i];
        i++;
        if(i >= size) break;
      end
    join_none
  endtask : driver_filter

endclass : test_fir
