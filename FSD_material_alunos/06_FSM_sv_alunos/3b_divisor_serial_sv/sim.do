if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -work work divisor_serial.sv
vlog -work work divisor_serial_tb.sv

vsim -voptargs=+acc=lprn -t ns work.tb

do wave.do 

run 2400 ns

