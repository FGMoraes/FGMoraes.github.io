
##Generate power ring with 0.25um spacing (between metal lines), 0.5um width and 1.5um offset from the core. Use M1 for horizontal and M2 for vertical
add_rings -spacing 0.25 -width 0.5 -layer {top M2 bottom M2 left M1 right M1} -jog_distance 2.5 -offset 1.5 -nets {gnd vdd} -threshold 2.5

##Route power rails using M1
route_special -connect {block_pin pad_pin pad_ring core_pin floating_stripe} -layer_change_range { M1(1) LB(11) } -block_pin_target nearest_target -pad_pin_port_connect {all_port one_geom} -pad_pin_target nearest_target -core_pin_target first_after_row_end -floating_stripe_target {block_ring pad_ring ring stripe ring_pin block_pin followpin} -allow_jogging 1 -crossover_via_layer_range { M1(1) LB(11) } -nets { gnd vdd } -allow_layer_change 1 -block_pin use_lef -target_via_layer_range { M1(1) LB(11) }

##Add well taps
add_well_taps -cell  C12T28SOI_LR_FILLERNPW4 -cell_interval 20 -fixed_gap -prefix WELLTAP -in_row_offset 6.0

##Add power stripes
add_stripes -block_ring_top_layer_limit M3 -max_same_layer_jog_length 6 -pad_core_ring_bottom_layer_limit M1 -set_to_set_distance 25 -pad_core_ring_top_layer_limit M3 -spacing 4 -merge_stripes_value 2.5 -layer M1 -block_ring_bottom_layer_limit M1 -width 0.4 -nets {gnd vdd}

gui_fit
