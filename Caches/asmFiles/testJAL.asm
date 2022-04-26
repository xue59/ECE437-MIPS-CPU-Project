	org   0x0000
	JAL mul
	HALT
mul:    ORI $3, $3, 0x00000004
	JR $31
