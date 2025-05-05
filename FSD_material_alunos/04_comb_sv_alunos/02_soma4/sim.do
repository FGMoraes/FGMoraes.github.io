if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -work work  FA.sv
vlog -work work  sum4.sv
vlog -work work  tb_sum4.sv

vsim -voptargs=+acc -t ns work.tb

do wave.do

run 100 ns

