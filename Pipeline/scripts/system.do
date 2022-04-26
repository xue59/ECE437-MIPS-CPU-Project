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
add wave -noupdate -group PC /system_tb/DUT/CPU/DP/PC
add wave -noupdate -group PC /system_tb/DUT/CPU/DP/new_pc
add wave -noupdate -group PC /system_tb/DUT/CPU/DP/next_pc
add wave -noupdate -group PC /system_tb/DUT/CPU/DP/BranchAddr
add wave -noupdate -group PC /system_tb/DUT/CPU/DP/JumpAddr
add wave -noupdate -group datapath /system_tb/DUT/CPU/dcif/halt
add wave -noupdate -group datapath /system_tb/DUT/CPU/dcif/ihit
add wave -noupdate -group datapath /system_tb/DUT/CPU/dcif/imemREN
add wave -noupdate -group datapath /system_tb/DUT/CPU/dcif/imemload
add wave -noupdate -group datapath /system_tb/DUT/CPU/dcif/imemaddr
add wave -noupdate -group datapath /system_tb/DUT/CPU/dcif/dhit
add wave -noupdate -group datapath /system_tb/DUT/CPU/dcif/dmemREN
add wave -noupdate -group datapath /system_tb/DUT/CPU/dcif/dmemWEN
add wave -noupdate -group datapath /system_tb/DUT/CPU/dcif/flushed
add wave -noupdate -group datapath /system_tb/DUT/CPU/dcif/dmemload
add wave -noupdate -group datapath /system_tb/DUT/CPU/dcif/dmemstore
add wave -noupdate -group datapath /system_tb/DUT/CPU/dcif/dmemaddr
add wave -noupdate -group {ctrl unit} /system_tb/DUT/CPU/DP/cuif/instruction
add wave -noupdate -group {ctrl unit} /system_tb/DUT/CPU/DP/cuif/shamt
add wave -noupdate -group {ctrl unit} /system_tb/DUT/CPU/DP/cuif/imm26
add wave -noupdate -group {ctrl unit} /system_tb/DUT/CPU/DP/cuif/ALUOp
add wave -noupdate -group {ctrl unit} /system_tb/DUT/CPU/DP/cuif/aluSrc
add wave -noupdate -group {ctrl unit} /system_tb/DUT/CPU/DP/cuif/RegDest
add wave -noupdate -group {ctrl unit} /system_tb/DUT/CPU/DP/cuif/jumpSel
add wave -noupdate -group {ctrl unit} /system_tb/DUT/CPU/DP/cuif/pcSrc
add wave -noupdate -group {ctrl unit} /system_tb/DUT/CPU/DP/cuif/memToReg
add wave -noupdate -group {ctrl unit} /system_tb/DUT/CPU/DP/cuif/RegWrite
add wave -noupdate -group {ctrl unit} /system_tb/DUT/CPU/DP/cuif/jal
add wave -noupdate -group {ctrl unit} /system_tb/DUT/CPU/DP/cuif/dREN
add wave -noupdate -group {ctrl unit} /system_tb/DUT/CPU/DP/cuif/dWEN
add wave -noupdate -group {ctrl unit} /system_tb/DUT/CPU/DP/cuif/imemREN
add wave -noupdate -group {ctrl unit} /system_tb/DUT/CPU/DP/cuif/lui
add wave -noupdate -group {ctrl unit} /system_tb/DUT/CPU/DP/cuif/bne
add wave -noupdate -group {ctrl unit} /system_tb/DUT/CPU/DP/cuif/halt
add wave -noupdate -group {ctrl unit} /system_tb/DUT/CPU/DP/cuif/rs
add wave -noupdate -group {ctrl unit} /system_tb/DUT/CPU/DP/cuif/rd
add wave -noupdate -group {ctrl unit} /system_tb/DUT/CPU/DP/cuif/rt
add wave -noupdate -group {ctrl unit} /system_tb/DUT/CPU/DP/cuif/imm
add wave -noupdate -group {reg file} /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate -group {reg file} /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate -group {reg file} /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate -group {reg file} /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate -group {reg file} /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate -group {reg file} /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate -group {reg file} /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate -expand -group alu /system_tb/DUT/CPU/DP/aluif/zero
add wave -noupdate -expand -group alu /system_tb/DUT/CPU/DP/aluif/negative
add wave -noupdate -expand -group alu /system_tb/DUT/CPU/DP/aluif/overflow
add wave -noupdate -expand -group alu /system_tb/DUT/CPU/DP/aluif/aluop
add wave -noupdate -expand -group alu /system_tb/DUT/CPU/DP/aluif/port_a
add wave -noupdate -expand -group alu /system_tb/DUT/CPU/DP/aluif/port_b
add wave -noupdate -expand -group alu /system_tb/DUT/CPU/DP/aluif/port_out
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
add wave -noupdate /system_tb/DUT/CPU/DP/REGF/myReg
add wave -noupdate -expand -group forward /system_tb/DUT/CPU/DP/fuif/rs
add wave -noupdate -expand -group forward /system_tb/DUT/CPU/DP/fuif/rt
add wave -noupdate -expand -group forward /system_tb/DUT/CPU/DP/fuif/rw_mem
add wave -noupdate -expand -group forward /system_tb/DUT/CPU/DP/fuif/rw_wb
add wave -noupdate -expand -group forward /system_tb/DUT/CPU/DP/fuif/ow_rdat1
add wave -noupdate -expand -group forward /system_tb/DUT/CPU/DP/fuif/ow_rdat2
add wave -noupdate -expand -group forward /system_tb/DUT/CPU/DP/fuif/regwrite_mem
add wave -noupdate -expand -group forward /system_tb/DUT/CPU/DP/fuif/regwrite_wb
add wave -noupdate -expand -group forward /system_tb/DUT/CPU/DP/fuif/mem_data
add wave -noupdate -expand -group forward /system_tb/DUT/CPU/DP/fuif/wb_data
add wave -noupdate -expand -group forward /system_tb/DUT/CPU/DP/fuif/replace_rs
add wave -noupdate -expand -group forward /system_tb/DUT/CPU/DP/fuif/replace_rt
add wave -noupdate -group if_id /system_tb/DUT/CPU/DP/iiif/instruction_in
add wave -noupdate -group if_id /system_tb/DUT/CPU/DP/iiif/next_pc_in
add wave -noupdate -group if_id /system_tb/DUT/CPU/DP/iiif/instruction_out
add wave -noupdate -group if_id /system_tb/DUT/CPU/DP/iiif/next_pc_out
add wave -noupdate -group if_id /system_tb/DUT/CPU/DP/iiif/ihit
add wave -noupdate -group if_id /system_tb/DUT/CPU/DP/iiif/flush
add wave -noupdate -group if_id /system_tb/DUT/CPU/DP/iiif/freeze
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/rdat1_in
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/rdat2_in
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/next_pc_in
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/shamt_in
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/ALUOp_in
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/ihit
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/flush
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/aluSrc_in
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/RegDest_in
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/jumpSel_in
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/pcSrc_in
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/memToReg_in
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/RegWrite_in
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/jal_in
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/dREN_in
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/dWEN_in
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/imemREN_in
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/lui_in
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/bne_in
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/halt_in
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/rd_in
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/rt_in
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/rs_in
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/imm_in
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/instruction_in
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/instruction_out
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/freeze
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/rdat1_out
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/rdat2_out
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/next_pc_out
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/shamt_out
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/ALUOp_out
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/aluSrc_out
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/RegDest_out
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/jumpSel_out
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/pcSrc_out
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/memToReg_out
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/RegWrite_out
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/jal_out
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/dREN_out
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/dWEN_out
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/imemREN_out
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/lui_out
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/bne_out
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/halt_out
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/rd_out
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/rt_out
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/rs_out
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/imm_out
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/imm26_in
add wave -noupdate -expand -group id_ex /system_tb/DUT/CPU/DP/ieif/imm26_out
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/ihit
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/dhit
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/rdat2_in
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/next_pc_in
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/memToReg_in
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/RegWrite_in
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/RegDest_in
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/jal_in
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/dREN_in
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/dWEN_in
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/imemREN_in
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/lui_in
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/rd_in
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/rt_in
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/imm_in
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/halt_in
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/port_out_in
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/instruction_in
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/instruction_out
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/rdat2_out
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/next_pc_out
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/memToReg_out
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/RegWrite_out
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/RegDest_out
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/jal_out
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/dREN_out
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/dWEN_out
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/imemREN_out
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/lui_out
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/rd_out
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/rt_out
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/imm_out
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/halt_out
add wave -noupdate -group ex_mem /system_tb/DUT/CPU/DP/emif/port_out_out
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/ihit
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/dhit
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/next_pc_in
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/memToReg_in
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/RegWrite_in
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/RegDest_in
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/jal_in
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/imemREN_in
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/lui_in
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/rd_in
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/rt_in
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/imm_in
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/halt_in
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/port_out_in
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/dmemload_in
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/next_pc_out
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/memToReg_out
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/RegWrite_out
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/RegDest_out
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/jal_out
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/imemREN_out
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/lui_out
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/rd_out
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/rt_out
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/imm_out
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/halt_out
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/dhit_out
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/port_out_out
add wave -noupdate -group mem_wb /system_tb/DUT/CPU/DP/mwif/dmemload_out
add wave -noupdate /system_tb/DUT/CPU/DP/opF
add wave -noupdate /system_tb/DUT/CPU/DP/funcF
add wave -noupdate /system_tb/DUT/CPU/DP/opD
add wave -noupdate /system_tb/DUT/CPU/DP/funcD
add wave -noupdate /system_tb/DUT/CPU/DP/opX
add wave -noupdate /system_tb/DUT/CPU/DP/funcX
add wave -noupdate /system_tb/DUT/CPU/DP/opM
add wave -noupdate /system_tb/DUT/CPU/DP/funcM
add wave -noupdate /system_tb/DUT/CPU/DP/opW
add wave -noupdate /system_tb/DUT/CPU/DP/funcW
add wave -noupdate -expand -group {hazard unit} /system_tb/DUT/CPU/DP/huif/freeze
add wave -noupdate -expand -group {hazard unit} /system_tb/DUT/CPU/DP/huif/flush
add wave -noupdate -expand -group {hazard unit} /system_tb/DUT/CPU/DP/huif/pcSrc
add wave -noupdate -expand -group {hazard unit} /system_tb/DUT/CPU/DP/huif/bne
add wave -noupdate -expand -group {hazard unit} /system_tb/DUT/CPU/DP/huif/zero
add wave -noupdate -expand -group {hazard unit} /system_tb/DUT/CPU/DP/huif/dhit
add wave -noupdate -expand -group {hazard unit} /system_tb/DUT/CPU/DP/huif/regwrite_m
add wave -noupdate -expand -group {hazard unit} /system_tb/DUT/CPU/DP/huif/jumpSel
add wave -noupdate -expand -group {hazard unit} /system_tb/DUT/CPU/DP/huif/instruction
add wave -noupdate -expand -group {hazard unit} /system_tb/DUT/CPU/DP/huif/rs_d
add wave -noupdate -expand -group {hazard unit} /system_tb/DUT/CPU/DP/huif/rt_d
add wave -noupdate -expand -group {hazard unit} /system_tb/DUT/CPU/DP/huif/rw_m
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {154761 ps} 0}
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
WaveRestoreZoom {0 ps} {791494 ps}
