set_distributed_hosts -local
set_multi_cpu_usage -local_cpu max -remote_host 1 -cpu_per_remote_host 28

set TOP_MODULE nanoCPU

set_db init_power_nets {vdd}
set_db init_ground_nets {gnd}    

read_db nanoCPU_genus.db

connect_global_net vdd -type pg_pin -pin_base_name vdd -inst_base_name *
connect_global_net gnd -type pg_pin -pin_base_name gnd -inst_base_name *
connect_global_net vdd -type tie_hi -inst_base_name *
connect_global_net gnd -type tie_lo -inst_base_name *

##Generating square floorplan (1) with 80% of density (0.85) with 3um margins 
create_floorplan -site CORE12T -core_density_size 1 0.85 3 3 3 3 

gui_fit
