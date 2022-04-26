onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -group cache /system_tb/DUT/CPU/ccif/iwait
add wave -noupdate -group cache /system_tb/DUT/CPU/ccif/dwait
add wave -noupdate -group cache /system_tb/DUT/CPU/ccif/iREN
add wave -noupdate -group cache /system_tb/DUT/CPU/ccif/dREN
add wave -noupdate -group cache /system_tb/DUT/CPU/ccif/dWEN
add wave -noupdate -group cache /system_tb/DUT/CPU/ccif/iload
add wave -noupdate -group cache /system_tb/DUT/CPU/ccif/dload
add wave -noupdate -group cache /system_tb/DUT/CPU/ccif/dstore
add wave -noupdate -group cache /system_tb/DUT/CPU/ccif/iaddr
add wave -noupdate -group cache /system_tb/DUT/CPU/ccif/daddr
add wave -noupdate -group cache /system_tb/DUT/CPU/ccif/ramWEN
add wave -noupdate -group cache /system_tb/DUT/CPU/ccif/ramREN
add wave -noupdate -group cache /system_tb/DUT/CPU/ccif/ramstate
add wave -noupdate -group cache /system_tb/DUT/CPU/ccif/ramaddr
add wave -noupdate -group cache /system_tb/DUT/CPU/ccif/ramstore
add wave -noupdate -group cache /system_tb/DUT/CPU/ccif/ramload
add wave -noupdate -group ram /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate -group ram /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate -group ram /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate -group ram /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate -group ram /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate -group ram /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate -group ram /system_tb/DUT/RAM/ramif/memREN
add wave -noupdate -group ram /system_tb/DUT/RAM/ramif/memWEN
add wave -noupdate -group ram /system_tb/DUT/RAM/ramif/memaddr
add wave -noupdate -group ram /system_tb/DUT/RAM/ramif/memstore
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/i
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/offset
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/tag
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/ind
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/row_trunc
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/miss
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/state
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/next_state
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/left_tag
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/right_tag
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/left_data1
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/left_data2
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/right_data1
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/right_data2
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/left_dirty
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/left_valid
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/right_dirty
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/right_valid
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/snooptag
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/snoopind
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/snoopoffset
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/snoophitL
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/snoophitR
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/snoopdirty
add wave -noupdate -expand -group DCACHE0 /system_tb/DUT/CPU/CM0/DCACHE/j
add wave -noupdate -expand -group DCACHE0 -expand /system_tb/DUT/CPU/CM0/DCACHE/ht
add wave -noupdate -group ICACHE0 /system_tb/DUT/CPU/CM0/ICACHE/i
add wave -noupdate -group ICACHE0 /system_tb/DUT/CPU/CM0/ICACHE/tag
add wave -noupdate -group ICACHE0 /system_tb/DUT/CPU/CM0/ICACHE/index
add wave -noupdate -group ICACHE0 /system_tb/DUT/CPU/CM0/ICACHE/imemload
add wave -noupdate -group ICACHE0 /system_tb/DUT/CPU/CM0/ICACHE/ihit
add wave -noupdate -group ICACHE0 /system_tb/DUT/CPU/CM0/ICACHE/miss
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/PC
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/new_pc
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/opF
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/opD
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/opX
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/opM
add wave -noupdate -expand -group DP0 /system_tb/DUT/CPU/DP0/opW
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/i
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/offset
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/tag
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/ind
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/row_trunc
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/miss
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/row
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_row
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/hit_count
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_hit_count
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/state
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/next_state
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/left_tag
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/right_tag
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/left_data1
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/left_data2
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/right_data1
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/right_data2
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/left_dirty
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/left_valid
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/right_dirty
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/right_valid
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/snooptag
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/snoopind
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/snoopoffset
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/snoophitL
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/snoophitR
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/snoopdirty
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/j
add wave -noupdate -group DCACHE1 /system_tb/DUT/CPU/CM1/DCACHE/ht
add wave -noupdate -group ICACHE1 /system_tb/DUT/CPU/CM1/ICACHE/i
add wave -noupdate -group ICACHE1 /system_tb/DUT/CPU/CM1/ICACHE/tag
add wave -noupdate -group ICACHE1 /system_tb/DUT/CPU/CM1/ICACHE/index
add wave -noupdate -group ICACHE1 /system_tb/DUT/CPU/CM1/ICACHE/imemload
add wave -noupdate -group ICACHE1 /system_tb/DUT/CPU/CM1/ICACHE/ihit
add wave -noupdate -group ICACHE1 /system_tb/DUT/CPU/CM1/ICACHE/miss
add wave -noupdate -expand -group DP1 /system_tb/DUT/CPU/DP1/PC
add wave -noupdate -expand -group DP1 /system_tb/DUT/CPU/DP1/new_pc
add wave -noupdate -expand -group DP1 /system_tb/DUT/CPU/DP1/opF
add wave -noupdate -expand -group DP1 /system_tb/DUT/CPU/DP1/opD
add wave -noupdate -expand -group DP1 /system_tb/DUT/CPU/DP1/opX
add wave -noupdate -expand -group DP1 /system_tb/DUT/CPU/DP1/opM
add wave -noupdate -expand -group DP1 /system_tb/DUT/CPU/DP1/opW
add wave -noupdate -group cc /system_tb/DUT/CPU/CC/ccif/iwait
add wave -noupdate -group cc /system_tb/DUT/CPU/CC/ccif/dwait
add wave -noupdate -group cc /system_tb/DUT/CPU/CC/ccif/iREN
add wave -noupdate -group cc /system_tb/DUT/CPU/CC/ccif/dREN
add wave -noupdate -group cc /system_tb/DUT/CPU/CC/ccif/dWEN
add wave -noupdate -group cc /system_tb/DUT/CPU/CC/ccif/iload
add wave -noupdate -group cc /system_tb/DUT/CPU/CC/ccif/dload
add wave -noupdate -group cc /system_tb/DUT/CPU/CC/ccif/dstore
add wave -noupdate -group cc /system_tb/DUT/CPU/CC/ccif/iaddr
add wave -noupdate -group cc /system_tb/DUT/CPU/CC/ccif/daddr
add wave -noupdate -group cc /system_tb/DUT/CPU/CC/ccif/ccwait
add wave -noupdate -group cc /system_tb/DUT/CPU/CC/ccif/ccinv
add wave -noupdate -group cc /system_tb/DUT/CPU/CC/ccif/ccwrite
add wave -noupdate -group cc /system_tb/DUT/CPU/CC/ccif/cctrans
add wave -noupdate -group cc /system_tb/DUT/CPU/CC/ccif/ccsnoopaddr
add wave -noupdate -group cc /system_tb/DUT/CPU/CC/ccif/ramWEN
add wave -noupdate -group cc /system_tb/DUT/CPU/CC/ccif/ramREN
add wave -noupdate -group cc /system_tb/DUT/CPU/CC/ccif/ramstate
add wave -noupdate -group cc /system_tb/DUT/CPU/CC/ccif/ramaddr
add wave -noupdate -group cc /system_tb/DUT/CPU/CC/ccif/ramstore
add wave -noupdate -group cc /system_tb/DUT/CPU/CC/ccif/ramload
add wave -noupdate -group cc_ /system_tb/DUT/CPU/CC/state
add wave -noupdate -group cc_ /system_tb/DUT/CPU/CC/next_state
add wave -noupdate -group cc_ /system_tb/DUT/CPU/CC/snooper
add wave -noupdate -group cc_ /system_tb/DUT/CPU/CC/snoopy
add wave -noupdate -group cc_ /system_tb/DUT/CPU/CC/next_snooper
add wave -noupdate -group cc_ /system_tb/DUT/CPU/CC/next_snoopy
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/halt
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/ihit
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/imemREN
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/imemload
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/imemaddr
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/dhit
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/dmemREN
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/dmemWEN
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/flushed
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/dmemload
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/dmemstore
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/dmemaddr
add wave -noupdate -expand -group dcif0 /system_tb/DUT/CPU/dcif0/datomic
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/dcif1/halt
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/dcif1/ihit
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/dcif1/imemREN
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/dcif1/imemload
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/dcif1/imemaddr
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/dcif1/dhit
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/dcif1/dmemREN
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/dcif1/dmemWEN
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/dcif1/flushed
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/dcif1/dmemload
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/dcif1/dmemstore
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/dcif1/dmemaddr
add wave -noupdate -expand -group dcif1 /system_tb/DUT/CPU/dcif1/datomic
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3152124 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 259
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
WaveRestoreZoom {2532840 ps} {3704344 ps}
