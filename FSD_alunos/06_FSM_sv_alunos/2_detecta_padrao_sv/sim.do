if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -work work detecta_padrao.sv
vlog -work work detecta_padrao_tb.sv

vsim -voptargs=+acc=lprn -t ns work.tb

do wave.do 

run 400 ns

