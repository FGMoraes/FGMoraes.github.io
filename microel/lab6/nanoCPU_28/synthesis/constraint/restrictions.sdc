##############################################################
## Logical / Physical synthesis constraints ##
##############################################################
set sdc_version 2.0
set_units -capacitance pF -time ns

# 500 MHz freq
create_clock -name {ck} -period 2.0 [get_ports {ck}]

set_false_path -from [get_ports {rst}] 

## INPUTS
set_input_delay -clock ck -max 0.03 [all_inputs]

# Output delay
set_output_delay -clock ck 0.03 [all_outputs]

# Output pins should support to drive a load of an inverter
set_load 0.000570 [all_outputs]
