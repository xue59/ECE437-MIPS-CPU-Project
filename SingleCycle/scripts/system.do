onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -group pc /system_tb/DUT/CPU/DP/pcif/npc
add wave -noupdate -group pc /system_tb/DUT/CPU/DP/pcif/PC
add wave -noupdate -group pc /system_tb/DUT/CPU/DP/pcif/new_pc
add wave -noupdate -group pc /system_tb/DUT/CPU/DP/pcif/PCEN
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/instruction
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/CTRLU/opcode
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/CTRLU/func
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/PCSrc
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/MemtoReg
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/RegWEN
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/JAL
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/halt
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/dWEN
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/dREN
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/imemREN
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/LUI
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/BNE
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/ALUSrc
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/RegDest
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/JumpSel
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/aluop
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/rs
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/rt
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/rd
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/imm
add wave -noupdate -expand -group cuif /system_tb/DUT/CPU/DP/cuif/shamt
add wave -noupdate -group {request unit} /system_tb/DUT/CPU/DP/ruif/dWEN
add wave -noupdate -group {request unit} /system_tb/DUT/CPU/DP/ruif/dREN
add wave -noupdate -group {request unit} /system_tb/DUT/CPU/DP/ruif/dhit
add wave -noupdate -group {request unit} /system_tb/DUT/CPU/DP/ruif/ihit
add wave -noupdate -group {request unit} /system_tb/DUT/CPU/DP/ruif/dmemREN
add wave -noupdate -group {request unit} /system_tb/DUT/CPU/DP/ruif/dmemWEN
add wave -noupdate -group {request unit} /system_tb/DUT/CPU/DP/ruif/PCEN
add wave -noupdate -group datapath /system_tb/DUT/CPU/DP/dpif/halt
add wave -noupdate -group datapath /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate -group datapath /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate -group datapath /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate -group datapath /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate -group datapath /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate -group datapath /system_tb/DUT/CPU/DP/dpif/datomic
add wave -noupdate -group datapath /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate -group datapath /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate -group datapath /system_tb/DUT/CPU/DP/dpif/flushed
add wave -noupdate -group datapath /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate -group datapath /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate -group datapath /system_tb/DUT/CPU/DP/dpif/dmemaddr
add wave -noupdate -expand -group {register file} /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate -expand -group {register file} /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -expand -group {register file} /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate -expand -group {register file} /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -expand -group {register file} /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -expand -group {register file} /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -expand -group {register file} /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate -expand -group alu /system_tb/DUT/CPU/DP/aluif/negative
add wave -noupdate -expand -group alu /system_tb/DUT/CPU/DP/aluif/overflow
add wave -noupdate -expand -group alu /system_tb/DUT/CPU/DP/aluif/zero
add wave -noupdate -expand -group alu /system_tb/DUT/CPU/DP/aluif/aluop
add wave -noupdate -expand -group alu /system_tb/DUT/CPU/DP/aluif/porta
add wave -noupdate -expand -group alu /system_tb/DUT/CPU/DP/aluif/portb
add wave -noupdate -expand -group alu /system_tb/DUT/CPU/DP/aluif/porto
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramREN
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramWEN
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramaddr
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramstore
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramload
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/ramstate
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/memREN
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/memWEN
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/memaddr
add wave -noupdate -expand -group ram /system_tb/DUT/RAM/ramif/memstore
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {678534 ps} 0}
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
WaveRestoreZoom {652097 ps} {744627 ps}
