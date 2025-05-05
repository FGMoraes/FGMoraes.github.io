if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -work work  FA.sv
vlog -work work  tb_FA.sv

vsim -voptargs=+acc -t ns work.tb

set StdVitalGlitchNoWarnings 1 

do wave.do

run 80 ns

