if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -work work fsm.sv
vlog -work work tb.sv

vsim -voptargs=+acc=lprn -t ns work.tb

do wave.do 

run 400 ns