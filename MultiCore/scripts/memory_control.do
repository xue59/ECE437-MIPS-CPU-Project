onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /memory_control_tb/CLK
add wave -noupdate /memory_control_tb/nRST
add wave -noupdate -group cif0 /memory_control_tb/cif0/iwait
add wave -noupdate -group cif0 /memory_control_tb/cif0/dwait
add wave -noupdate -group cif0 /memory_control_tb/cif0/iREN
add wave -noupdate -group cif0 /memory_control_tb/cif0/dREN
add wave -noupdate -group cif0 /memory_control_tb/cif0/dWEN
add wave -noupdate -group cif0 /memory_control_tb/cif0/iload
add wave -noupdate -group cif0 /memory_control_tb/cif0/dload
add wave -noupdate -group cif0 /memory_control_tb/cif0/dstore
add wave -noupdate -group cif0 /memory_control_tb/cif0/iaddr
add wave -noupdate -group cif0 /memory_control_tb/cif0/daddr
add wave -noupdate -group cif0 /memory_control_tb/cif0/ccwait
add wave -noupdate -group cif0 /memory_control_tb/cif0/ccinv
add wave -noupdate -group cif0 /memory_control_tb/cif0/ccwrite
add wave -noupdate -group cif0 /memory_control_tb/cif0/cctrans
add wave -noupdate -group cif0 /memory_control_tb/cif0/ccsnoopaddr
add wave -noupdate -group cif1 /memory_control_tb/cif1/iwait
add wave -noupdate -group cif1 /memory_control_tb/cif1/dwait
add wave -noupdate -group cif1 /memory_control_tb/cif1/iREN
add wave -noupdate -group cif1 /memory_control_tb/cif1/dREN
add wave -noupdate -group cif1 /memory_control_tb/cif1/dWEN
add wave -noupdate -group cif1 /memory_control_tb/cif1/iload
add wave -noupdate -group cif1 /memory_control_tb/cif1/dload
add wave -noupdate -group cif1 /memory_control_tb/cif1/dstore
add wave -noupdate -group cif1 /memory_control_tb/cif1/iaddr
add wave -noupdate -group cif1 /memory_control_tb/cif1/daddr
add wave -noupdate -group cif1 /memory_control_tb/cif1/ccwait
add wave -noupdate -group cif1 /memory_control_tb/cif1/ccinv
add wave -noupdate -group cif1 /memory_control_tb/cif1/ccwrite
add wave -noupdate -group cif1 /memory_control_tb/cif1/cctrans
add wave -noupdate -group cif1 /memory_control_tb/cif1/ccsnoopaddr
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/ramWEN
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/ramREN
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/ramstate
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/ramaddr
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/ramstore
add wave -noupdate -expand -group ccif /memory_control_tb/ccif/ramload
add wave -noupdate -expand -group DUT /memory_control_tb/DUT/state
add wave -noupdate -expand -group DUT /memory_control_tb/DUT/next_state
add wave -noupdate -expand -group DUT /memory_control_tb/DUT/snooper
add wave -noupdate -expand -group DUT /memory_control_tb/DUT/snoopy
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {106 ns} 0}
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
WaveRestoreZoom {0 ns} {352 ns}
