# Place pins in the chip sides
set_db assign_pins_edit_in_batch true
edit_pin -fix_overlap 1 -unit micron -spread_direction clockwise -side Left   -layer 2 -spread_type center -spacing 1.0 -pin {ck rst}
#edit_pin -fix_overlap 1 -unit micron -spread_direction clockwise -side Bottom  -layer 2 -spread_type center -spacing 1.0 -pin {}
edit_pin -fix_overlap 1 -unit micron -spread_direction clockwise -side Top    -layer 3 -spread_type center -spacing 1.0 -pin {address*}
edit_pin -fix_overlap 1 -unit micron -spread_direction clockwise -side Right  -layer 3 -spread_type center -spacing 1.0 -pin {dataR* dataW* ce we}
set_db assign_pins_edit_in_batch false

# posionamento
place_opt_design

## Clock tree synthesiscd 
clock_opt_design 
 