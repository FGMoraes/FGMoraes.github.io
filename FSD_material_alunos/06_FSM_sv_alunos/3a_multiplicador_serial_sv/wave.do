onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/dut/reset
add wave -noupdate /tb/dut/clock
add wave -noupdate -divider ENTRADAS
add wave -noupdate -radix hexadecimal /tb/dut/A
add wave -noupdate -radix hexadecimal /tb/dut/B
add wave -noupdate -divider CONTROLE
add wave -noupdate /tb/dut/start
add wave -noupdate /tb/dut/end_mul
add wave -noupdate -divider PRODUTO
add wave -noupdate -radix hexadecimal /tb/dut/produto
add wave -noupdate -divider {sinais internos}
add wave -noupdate -radix unsigned /tb/dut/cont
add wave -noupdate /tb/dut/regP
add wave -noupdate /tb/dut/EA
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {824 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
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
WaveRestoreZoom {0 ns} {1402 ns}
