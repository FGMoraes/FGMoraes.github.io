onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/dut/N
add wave -noupdate /tb/dut/reset
add wave -noupdate /tb/dut/clock
add wave -noupdate /tb/dut/start
add wave -noupdate -radix unsigned /tb/dut/A
add wave -noupdate -radix unsigned /tb/dut/B
add wave -noupdate /tb/dut/EA
add wave -noupdate -color Red /tb/dut/regPA
add wave -noupdate /tb/dut/regB
add wave -noupdate /tb/dut/sub
add wave -noupdate /tb/dut/sub(5)
add wave -noupdate /tb/dut/cont
add wave -noupdate -divider resultado
add wave -noupdate /tb/dut/end_div
add wave -noupdate -color Blue -height 25 -radix unsigned /tb/dut/QUO
add wave -noupdate -color Blue -height 25 -radix unsigned /tb/dut/RES
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1996 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ns} {2400 ns}
