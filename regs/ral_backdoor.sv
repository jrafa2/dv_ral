//register signals
regmap.fir_coef_0_reg.add_hdl_path_slice( .name("O_coef0"),            .offset(0), .size(8));
regmap.fir_coef_1_reg.add_hdl_path_slice( .name("O_coef1"),            .offset(0), .size(8));
regmap.fir_coef_2_reg.add_hdl_path_slice( .name("O_coef2"),            .offset(0), .size(8));
regmap.fir_div_reg.add_hdl_path_slice(    .name("O_coef_div"),         .offset(0), .size(8));

regmap.cic_coef_reg.add_hdl_path_slice(   .name("O_decimation_ratio"), .offset(0), .size(2));

regmap.chip_id_reg.add_hdl_path_slice(    .name("chip_id"),            .offset(0), .size(8));
regmap.control_reg.add_hdl_path_slice(    .name("O_conv_en"),          .offset(0), .size(1));
regmap.output_reg.add_hdl_path_slice(     .name("I_adc_data"),         .offset(0), .size(8));

//base path
regmap.add_hdl_path("top.dut.u_regs");