#----------------------------------------------------------
# First Processor
#----------------------------------------------------------
  org   0x0000              # first processor p0
  ori   $sp, $zero, 0x3ffc  # stack
  jal   mainp0              # go to program
  halt

mainp0:
  push  $ra                 # save return address 
  ori   $t6, $zero, 256     # set max rands to 256
  ori   $t9, $zero, 0x90       # set seed to 5
  ori   $t7, $zero, 0   # initialize temp reg 8 to zero (this is our counter for number of randoms generated)
genRand:

  # generate random number
  or   $a0, $zero, $t9    # set argument to previous value (or seed if first loop)
  jal   crc32               # generate random 
  or   $t8, $zero, $v0     # set temp register to result of crc32

  # push result
  ori   $a0, $zero, l1      # move lock to arguement register
  jal   lock                # aquire the lock
  or   $a0, $zero, $t8     # set argument 0 to value of random
  jal   pushVal             # push argument 0 to stack
  ori   $a0, $zero, l1      # move lock to arguement register
  jal   unlock              # release lock

  # seed = result
  or   $t9, $zero, $t8    # set seed reg to random value result

  # if not done, go to generate
  addi  $t7, $t7, 1
  bne   $t7, $t6, genRand   # branch as long as counter is not equal to 256         

  pop   $ra                 # get return address
  jr    $ra                 # return to caller

l1:
  cfw 0x0


#----------------------------------------------------------
# Second Processor
#----------------------------------------------------------
  org   0x1000               # second processor p1
  ori   $sp, $zero, 0x7ffc  # stack
  jal   mainp1              # go to program
  halt

mainp1:
  push  $ra                 # save return address
  ori   $t5, $zero, 256
  ori   $t6, $zero, 0   # initialize temp reg 7 to zero (this is our counter for number of randoms generated)

  #initialize results
  ori   $s0, $zero, 0xFFFFFFFF  # Min value
  ori   $s1, $zero, 0x00000000  # Max value
  ori   $s2, $zero, 0           # sum of random values 

popNextVal:
  #verify there are values in the stack
  jal   checkStack

  # obtain locks and pop values
  ori   $a0, $zero, l1      # move lock to arguement register
  jal   lock                # aquire the lock
  jal   popVal              # pop top value from stack
  or    $t7, $zero, $v0     # Move popped value to t7
  ori   $a0, $zero, l1      # move lock to arguement register
  jal   unlock              # release lock

  # write the computation algorithm
  #-max (a0=a,a1=b) returns v0=max(a,b)
  #-min (a0=a,a1=b) returns v0=min(a,b)

  # min calculation
  andi   $a0, $s0, 0x0000FFFF
  andi   $a1, $t7, 0x0000FFFF
  jal  min
  or   $s0, $zero, $v0
  
  # max calculation
  andi   $a0, $s1, 0x0000FFFF
  jal  max
  or   $s1, $zero, $v0

  # compute sum and store in S2
  andi $t7, $t7, 0x0000FFFF
  add $s2, $s2, $t7

  
  # increment counter and branch
  addi  $t6, $t6, 1
  bne   $t6, $t5, popNextVal

  # final calculation for average and remainder
  or $a0, $zero, $s2
  or $a1, $zero, $t5
  jal divide
  or $s2, $zero, $v0
  or $s3, $zero, $v1
  # average is in $s2 and remainder in $s3
  
  ori $t0, $zero, min_res
  sw $s0, 0($t0)
  ori $t0, $zero, max_res
  sw $s1, 0($t0)
  ori $t0, $zero, avg_res
  sw $s2, 0($t0)

  pop   $ra                 # get return address
  jr    $ra                 # return to caller

res:
  cfw 0x0                   

#---------------------------------------------------------
# Lock and Unlock
#---------------------------------------------------------
# pass in an address to lock function in argument register 0
# returns when lock is available
lock:
aquire:
  ll    $t0, 0($a0)         # load lock location
  bne   $t0, $0, aquire     # wait on lock to be open
  addiu $t0, $t0, 1
  sc    $t0, 0($a0)
  beq   $t0, $0, lock       # if sc failed retry
  jr    $ra


# pass in an address to unlock function in argument register 0
# returns when lock is free
unlock:
  sw    $0, 0($a0)
  jr    $ra

#-----------------------------------------------------------
# Push and Pop functions
#-----------------------------------------------------------

# loop until the offset is greater than 0
checkStack:
  ori $t0, $zero, gstackptr
  lw $t1, 0($t0)                      # load the offset
  #slt $t2, $t1, $zero
  beq $t1, $zero, checkStack
  jr   $ra                            # return to caller

pushVal:
  ori $t0, $zero, gstackptr
  lw $t1, 0($t0)                      # load the offset
  
  ori $t2, $zero, gstackbase
  lw $t3, 0($t2)                      # load the stack base

  sub $t3, $t3, $t1                   # loc to store

  sw   $a0, 0($t3)                    # store the val into the stack
  addi $t1, $t1, 4                    # dec the sp (inc the offset)
  sw   $t1, 0($t0)                    # update the offset

  jr   $ra                            # return to caller


popVal:
  ori $t0, $zero, gstackptr
  lw $t1, 0($t0)                      # load the offset
  
  ori $t2, $zero, gstackbase
  lw $t3, 0($t2)                      # load the stack base

  addi $t1, $t1, -4                   # get the offset we want
  sub $t3, $t3, $t1                   # loc to store

  lw $v0, 0($t3)                      # fetch the val from the stack
  sw $zero, 0($t3)                    # clean the loc
  sw $t1, 0($t0)                      # sp is already at the next available loc

  jr    $ra                 # return to caller





#REGISTERS
#at $1 at
#v $2-3 function returns
#a $4-7 function args
#t $8-15 temps
#s $16-23 saved temps (callee preserved)
#t $24-25 temps
#k $26-27 kernel
#gp $28 gp (callee preserved)
#sp $29 sp (callee preserved)
#fp $30 fp (callee preserved)
#ra $31 return address

# USAGE random0 = crc(seed), random1 = crc(random0)
#       randomN = crc(randomN-1)
#------------------------------------------------------
# $v0 = crc32($a0)
crc32:
  lui $t1, 0x04C1
  ori $t1, $t1, 0x1DB7
  or $t2, $0, $0
  ori $t3, $0, 32

crcl1:
  slt $t4, $t2, $t3
  beq $t4, $zero, crcl2

  srl $t4, $a0, 31
  sll $a0, $a0, 1
  beq $t4, $0, crcl3
  xor $a0, $a0, $t1
crcl3:
  addiu $t2, $t2, 1
  j crcl1
crcl2:
  or $v0, $a0, $0
  jr $ra
#------------------------------------------------------

# registers a0-1,v0-1,t0
# a0 = Numerator
# a1 = Denominator
# v0 = Quotient
# v1 = Remainder

#-divide(N=$a0,D=$a1) returns (Q=$v0,R=$v1)--------
divide:               # setup frame
  push  $ra           # saved return address
  push  $a0           # saved register
  push  $a1           # saved register
  or    $v0, $0, $0   # Quotient v0=0
  or    $v1, $0, $a0  # Remainder t2=N=a0
  beq   $0, $a1, divrtn # test zero D
  slt   $t0, $a1, $0  # test neg D
  bne   $t0, $0, divdneg
  slt   $t0, $a0, $0  # test neg N
  bne   $t0, $0, divnneg
divloop:
  slt   $t0, $v1, $a1 # while R >= D
  bne   $t0, $0, divrtn
  addiu $v0, $v0, 1   # Q = Q + 1
  subu  $v1, $v1, $a1 # R = R - D
  j     divloop
divnneg:
  subu  $a0, $0, $a0  # negate N
  jal   divide        # call divide
  subu  $v0, $0, $v0  # negate Q
  beq   $v1, $0, divrtn
  addiu $v0, $v0, -1  # return -Q-1
  j     divrtn
divdneg:
  subu  $a0, $0, $a1  # negate D
  jal   divide        # call divide
  subu  $v0, $0, $v0  # negate Q
divrtn:
  pop $a1
  pop $a0
  pop $ra
  jr  $ra
#-divide--------------------------------------------

# registers a0-1,v0,t0
# a0 = a
# a1 = b
# v0 = result

#-max (a0=a,a1=b) returns v0=max(a,b)--------------
max:
  push  $ra
  push  $a0
  push  $a1
  or    $v0, $0, $a0
  slt   $t0, $a0, $a1
  beq   $t0, $0, maxrtn
  or    $v0, $0, $a1
maxrtn:
  pop   $a1
  pop   $a0
  pop   $ra
  jr    $ra
#--------------------------------------------------

#-min (a0=a,a1=b) returns v0=min(a,b)--------------
min:
  push  $ra
  push  $a0
  push  $a1
  or    $v0, $0, $a0
  slt   $t0, $a1, $a0
  beq   $t0, $0, minrtn
  or    $v0, $0, $a1
minrtn:
  pop   $a1
  pop   $a0
  pop   $ra
  jr    $ra
#--------------------------------------------------

gstackptr:
  cfw 0x0000

gstackbase:
  cfw 0x9000

org 0xE000
max_res:
  cfw 0xBAD1BAD1
min_res:
  cfw 0xBAD2BAD2
avg_res:
  cfw 0xBAD3BAD3
