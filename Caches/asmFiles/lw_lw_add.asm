#--------------------------------------
# Test with a fibonacci sequence
#--------------------------------------
  org 0x0000

  ori   $6, $zero, 0x0F00
  ori   $8, $zero, 2
  ori   $7, $zero, 0x0F44
  ori   $9, $zero, 0x0F44
ZZZ:
  lw    $15, 0($6)
  lw    $16, 8($6)
  add   $17, $15, $16
  addi  $8, $8, -1
  sw    $8, 0($6)
  bne   $8, $0, ZZZ
  sw    $17, 0($6)
halt



  org 0x0F00
  cfw 16
  cfw 15
  cfw 32
  cfw 31
