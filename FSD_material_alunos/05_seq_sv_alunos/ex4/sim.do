if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -work work ex4.sv
vlog -work work ex4_tb.sv

vsim -voptargs=+acc=lprn -t ns work.tb

add wave -noupdate /tb/reset
add wave -noupdate /tb/ck
add wave -noupdate -divider {registradores}
add wave -noupdate -radix unsigned /tb/dut/opA
add wave -noupdate -radix unsigned /tb/dut/opB
add wave -noupdate -divider {saida}
add wave -noupdate -radix unsigned /tb/dut/saida

run 800 ns

