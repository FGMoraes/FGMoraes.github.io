if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -work work ex5.sv
vlog -work work ex5_tb.sv

vsim -voptargs=+acc=lprn -t ns work.tb

do wave.do 

run 220 ns

