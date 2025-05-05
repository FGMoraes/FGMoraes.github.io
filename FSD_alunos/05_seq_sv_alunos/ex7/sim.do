if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -work work ex7.sv
vlog -work work ex7_tb.sv

vsim -voptargs=+acc=lprn -t ns work.tb


do wave.do 

run 300 ns

