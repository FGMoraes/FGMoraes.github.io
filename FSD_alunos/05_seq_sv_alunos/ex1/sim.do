if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -work work ex1.sv

vsim -voptargs=+acc=lprn -t ns work.tb

add wave -noupdate /tb/reset
add wave -noupdate /tb/ck
add wave -noupdate /tb/ce
add wave -noupdate  -radix hexadecimal /tb/D
add wave -noupdate -divider {mestre-escravo}
add wave -noupdate  -radix hexadecimal /tb/q_ms
add wave -noupdate -divider {latch}
add wave -noupdate  -radix hexadecimal /tb/q_lt

run 300 ns

