onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /dcache_tb/CLK
add wave -noupdate /dcache_tb/nRST
add wave -noupdate -group RAM /dcache_tb/cif/iwait
add wave -noupdate -group RAM /dcache_tb/cif/dwait
add wave -noupdate -group RAM /dcache_tb/cif/iREN
add wave -noupdate -group RAM /dcache_tb/cif/dREN
add wave -noupdate -group RAM /dcache_tb/cif/dWEN
add wave -noupdate -group RAM /dcache_tb/cif/iload
add wave -noupdate -group RAM /dcache_tb/cif/dload
add wave -noupdate -group RAM /dcache_tb/cif/dstore
add wave -noupdate -group RAM /dcache_tb/cif/iaddr
add wave -noupdate -group RAM /dcache_tb/cif/daddr
add wave -noupdate -group RAM /dcache_tb/cif/ccwait
add wave -noupdate -group RAM /dcache_tb/cif/ccinv
add wave -noupdate -group RAM /dcache_tb/cif/ccwrite
add wave -noupdate -group RAM /dcache_tb/cif/cctrans
add wave -noupdate -group RAM /dcache_tb/cif/ccsnoopaddr
add wave -noupdate -group Datapath /dcache_tb/dcif/halt
add wave -noupdate -group Datapath /dcache_tb/dcif/ihit
add wave -noupdate -group Datapath /dcache_tb/dcif/imemREN
add wave -noupdate -group Datapath /dcache_tb/dcif/imemload
add wave -noupdate -group Datapath /dcache_tb/dcif/imemaddr
add wave -noupdate -group Datapath /dcache_tb/dcif/dhit
add wave -noupdate -group Datapath /dcache_tb/dcif/datomic
add wave -noupdate -group Datapath /dcache_tb/dcif/dmemREN
add wave -noupdate -group Datapath /dcache_tb/dcif/dmemWEN
add wave -noupdate -group Datapath /dcache_tb/dcif/flushed
add wave -noupdate -group Datapath /dcache_tb/dcif/dmemload
add wave -noupdate -group Datapath /dcache_tb/dcif/dmemstore
add wave -noupdate -group Datapath /dcache_tb/dcif/dmemaddr
add wave -noupdate /dcache_tb/PROG/#ublk#502948#53/testNum
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {0 ns} {1 us}
