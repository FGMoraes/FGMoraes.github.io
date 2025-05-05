onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/N
add wave -noupdate -divider entradas
add wave -noupdate -radix unsigned /tb/A
add wave -noupdate -radix unsigned /tb/B
add wave -noupdate /tb/Cin
add wave -noupdate -divider saidas
add wave -noupdate -radix unsigned /tb/Sum
add wave -noupdate /tb/Cout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {49 ns} 0}
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
WaveRestoreZoom {0 ns} {53 ns}
