
add wave -noupdate /tb/dut/reset
add wave -noupdate /tb/dut/clock

add wave -noupdate -divider controleA
add wave -noupdate /tb/dut/SA
add wave -noupdate /tb/dut/enableA
add wave -noupdate -radix hexadecimal /tb/dut/X

add wave -noupdate -divider controleB
add wave -noupdate /tb/dut/SB
add wave -noupdate /tb/dut/enableB
add wave -noupdate -radix hexadecimal /tb/dut/Y

add wave -noupdate -divider multiplexadores

add wave -noupdate -color {Dark Orchid} -radix hexadecimal /tb/dut/xmux
add wave -noupdate -color {Dark Orchid} -radix hexadecimal /tb/dut/ymux
add wave -noupdate -divider registradores
add wave -noupdate -color {Dark Orchid} -radix hexadecimal /tb/dut/regA
add wave -noupdate -color {Dark Orchid} -radix hexadecimal /tb/dut/regB

add wave -noupdate -divider saida

add wave -noupdate -radix hexadecimal /tb/dut/RB

update
WaveRestoreZoom {0 ns} {220 ns}
