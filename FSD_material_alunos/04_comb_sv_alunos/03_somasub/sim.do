if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -work work  FA.sv
vlog -work work  sum_sub.sv
vlog -work work  tb_sum_sub.sv

vsim -voptargs=+acc -t ns work.tb

do wave.do

run 100 ns

