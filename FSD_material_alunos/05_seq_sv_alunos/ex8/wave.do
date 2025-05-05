onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/dut/clock
add wave -noupdate /tb/dut/reset
add wave -noupdate -divider entrada
add wave -noupdate -radix hexadecimal /tb/dut/entrada
add wave -noupdate /tb/dut/send
add wave -noupdate -divider registradores
add wave -noupdate -color {Medium Violet Red} -radix hexadecimal /tb/dut/A
add wave -noupdate -color {Medium Violet Red} -radix hexadecimal /tb/dut/B
add wave -noupdate -color {Medium Violet Red} -radix hexadecimal /tb/dut/C
add wave -noupdate -color {Medium Violet Red} -radix hexadecimal /tb/dut/D
add wave -noupdate -color {Pale Green} -radix unsigned /tb/dut/contIn
add wave -noupdate -divider soma
add wave -noupdate -radix hexadecimal /tb/dut/vet
add wave -noupdate -radix hexadecimal /tb/dut/regSoma
add wave -noupdate -radix hexadecimal /tb/dut/acumula
add wave -noupdate -radix unsigned /tb/dut/contOut
add wave -noupdate -divider saidas
add wave -noupdate /tb/req
add wave -noupdate -radix hexadecimal /tb/saida
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1171 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 283
configure wave -valuecolwidth 212
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {290 ns} {501 ns}
