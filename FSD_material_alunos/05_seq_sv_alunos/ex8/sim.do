if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -work work ex8.sv
vlog -work work ex8_tb.sv

vsim -voptargs=+acc=lprn -t ns work.tb

do wave.do 

run 1500 ns

