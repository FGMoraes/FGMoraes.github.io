if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -work work arbitro.sv
vlog -work work arbitro_tb.sv

vsim -voptargs=+acc=lprn -t ns work.tb

do wave.do 

run 1100 ns