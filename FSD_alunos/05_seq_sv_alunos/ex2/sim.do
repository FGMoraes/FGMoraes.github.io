if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -work work ex2.sv

vsim -voptargs=+acc=lprn -t ns work.tb


add wave -noupdate /tb/reset
add wave -noupdate /tb/ck
add wave -noupdate -divider {entrada}
add wave -noupdate  -radix unsigned /tb/entrada
add wave -noupdate -divider {saida dos flip-flops}
add wave -noupdate  -radix unsigned /tb/sr/A
add wave -noupdate  -radix unsigned /tb/sr/B
add wave -noupdate  -radix unsigned /tb/sr/C
add wave -noupdate -divider {somas}
add wave -noupdate  -radix unsigned /tb/sr/X
add wave -noupdate  -radix unsigned /tb/sr/Y

run 300 ns

