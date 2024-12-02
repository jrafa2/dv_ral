
// This file was autogenerated by PeakRDL-uvm
package regs;
    `include "uvm_macros.svh"
    import uvm_pkg::*;
    
    // Reg - reg_map::fir_coef_0
    class reg_map__fir_coef_0 extends uvm_reg;
        rand uvm_reg_field coef0;

        function new(string name = "reg_map__fir_coef_0");
            super.new(name, 8, UVM_NO_COVERAGE);
        endfunction : new

        virtual function void build();
            this.coef0 = new("coef0");
            this.coef0.configure(this, 8, 0, "RW", 1, 'h1, 1, 1, 0);
        endfunction : build
    endclass : reg_map__fir_coef_0

    // Reg - reg_map::fir_coef_1
    class reg_map__fir_coef_1 extends uvm_reg;
        rand uvm_reg_field coef1;

        function new(string name = "reg_map__fir_coef_1");
            super.new(name, 8, UVM_NO_COVERAGE);
        endfunction : new

        virtual function void build();
            this.coef1 = new("coef1");
            this.coef1.configure(this, 8, 0, "RW", 1, 'h0, 1, 1, 0);
        endfunction : build
    endclass : reg_map__fir_coef_1

    // Reg - reg_map::fir_coef_2
    class reg_map__fir_coef_2 extends uvm_reg;
        rand uvm_reg_field coef2;

        function new(string name = "reg_map__fir_coef_2");
            super.new(name, 8, UVM_NO_COVERAGE);
        endfunction : new

        virtual function void build();
            this.coef2 = new("coef2");
            this.coef2.configure(this, 8, 0, "RW", 1, 'h0, 1, 1, 0);
        endfunction : build
    endclass : reg_map__fir_coef_2

    // Reg - reg_map::fir_div
    class reg_map__fir_div extends uvm_reg;
        rand uvm_reg_field div;

        function new(string name = "reg_map__fir_div");
            super.new(name, 8, UVM_NO_COVERAGE);
        endfunction : new

        virtual function void build();
            this.div = new("div");
            this.div.configure(this, 8, 0, "RW", 1, 'h0, 1, 1, 0);
        endfunction : build
    endclass : reg_map__fir_div

    // Reg - reg_map::cic_coef
    class reg_map__cic_coef extends uvm_reg;
        rand uvm_reg_field dr;

        function new(string name = "reg_map__cic_coef");
            super.new(name, 8, UVM_NO_COVERAGE);
        endfunction : new

        virtual function void build();
            this.dr = new("dr");
            this.dr.configure(this, 2, 0, "RW", 1, 'h1, 1, 1, 0);
        endfunction : build
    endclass : reg_map__cic_coef

    // Reg - reg_map::chip_id
    class reg_map__chip_id extends uvm_reg;
        rand uvm_reg_field ID;

        function new(string name = "reg_map__chip_id");
            super.new(name, 8, UVM_NO_COVERAGE);
        endfunction : new

        virtual function void build();
            this.ID = new("ID");
            this.ID.configure(this, 8, 0, "RO", 0, 'ha5, 1, 1, 0);
        endfunction : build
    endclass : reg_map__chip_id

    // Reg - reg_map::control
    class reg_map__control extends uvm_reg;
        rand uvm_reg_field E;

        function new(string name = "reg_map__control");
            super.new(name, 8, UVM_NO_COVERAGE);
        endfunction : new

        virtual function void build();
            this.E = new("E");
            this.E.configure(this, 1, 0, "WO", 1, 'h0, 1, 1, 0);
        endfunction : build
    endclass : reg_map__control

    // Reg - reg_map::output
    class reg_map__output extends uvm_reg;
        rand uvm_reg_field out;

        function new(string name = "reg_map__output");
            super.new(name, 8, UVM_NO_COVERAGE);
        endfunction : new

        virtual function void build();
            this.out = new("out");
            this.out.configure(this, 8, 0, "RO", 0, 'h0, 1, 1, 0);
        endfunction : build
    endclass : reg_map__output

    // Addrmap - reg_map
    class reg_map extends uvm_reg_block;
        rand reg_map__fir_coef_0 fir_coef_0_reg;
        rand reg_map__fir_coef_1 fir_coef_1_reg;
        rand reg_map__fir_coef_2 fir_coef_2_reg;
        rand reg_map__fir_div fir_div_reg;
        rand reg_map__cic_coef cic_coef_reg;
        rand reg_map__chip_id chip_id_reg;
        rand reg_map__control control_reg;
        rand reg_map__output output_reg;

        function new(string name = "reg_map");
            super.new(name);
        endfunction : new

        virtual function void build();
            this.default_map = create_map("reg_map", 0, 1, UVM_NO_ENDIAN);
            this.fir_coef_0_reg = new("fir_coef_0_reg");
            this.fir_coef_0_reg.configure(this);

            this.fir_coef_0_reg.build();
            this.default_map.add_reg(this.fir_coef_0_reg, 'h0);
            this.fir_coef_1_reg = new("fir_coef_1_reg");
            this.fir_coef_1_reg.configure(this);

            this.fir_coef_1_reg.build();
            this.default_map.add_reg(this.fir_coef_1_reg, 'h1);
            this.fir_coef_2_reg = new("fir_coef_2_reg");
            this.fir_coef_2_reg.configure(this);

            this.fir_coef_2_reg.build();
            this.default_map.add_reg(this.fir_coef_2_reg, 'h2);
            this.fir_div_reg = new("fir_div_reg");
            this.fir_div_reg.configure(this);

            this.fir_div_reg.build();
            this.default_map.add_reg(this.fir_div_reg, 'h3);
            this.cic_coef_reg = new("cic_coef_reg");
            this.cic_coef_reg.configure(this);

            this.cic_coef_reg.build();
            this.default_map.add_reg(this.cic_coef_reg, 'h4);
            this.chip_id_reg = new("chip_id_reg");
            this.chip_id_reg.configure(this);

            this.chip_id_reg.build();
            this.default_map.add_reg(this.chip_id_reg, 'h5);
            this.control_reg = new("control_reg");
            this.control_reg.configure(this);

            this.control_reg.build();
            this.default_map.add_reg(this.control_reg, 'h6);
            this.output_reg = new("output_reg");
            this.output_reg.configure(this);

            this.output_reg.build();
            this.default_map.add_reg(this.output_reg, 'h7);
        endfunction : build
    endclass : reg_map

endpackage: regs