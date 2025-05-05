if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -work work ex6.sv
vlog -work work ex6_tb.sv

vsim -voptargs=+acc=lprn -t ns work.tb

do wave.do 

run 350 ns

