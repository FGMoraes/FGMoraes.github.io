if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -work work ex3.sv

vsim -voptargs=+acc=lprn -t ns work.tb

add wave -noupdate /tb/reset
add wave -noupdate /tb/ck
add wave -noupdate -divider {registradores}
add wave -noupdate -radix unsigned /tb/dut/R1
add wave -noupdate -radix unsigned /tb/dut/R2
add wave -noupdate -divider {saida}
add wave -noupdate -radix unsigned /tb/saida

run 800 ns

