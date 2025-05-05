onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -color black /tb/N
add wave -noupdate -divider entradas
add wave -noupdate -color black -radix hexadecimal /tb/A
add wave -noupdate -color black -radix hexadecimal /tb/B
add wave -noupdate -color black /tb/mode
add wave -noupdate -divider saidas
add wave -noupdate -color black -radix hexadecimal /tb/Sum
add wave -noupdate -color black /tb/Cout
add wave -noupdate -color black /tb/ov
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {29 ns} 0}
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
WaveRestoreZoom {0 ns} {74 ns}
