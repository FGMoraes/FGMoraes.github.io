if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -work work tx_serial.sv
vlog -work work tx_serial_tb.sv

vsim -voptargs=+acc=lprn -t ns work.tb
 
do wave.do 

run 600 ns

