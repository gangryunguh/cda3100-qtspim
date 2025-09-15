  .data
  .align 2
msg1: .asciiz "Type in the positive integer values of dividend and divisor: \n"
msg2: .asciiz "quotient = "
msg3: .asciiz "remainder = "
newline: .asciiz "\n"

    .text
    .align 2
    .globl printmsg
printmsg:
    # prolog
    addiu $sp,$sp,-4
    sw $31,0($sp)
    li $v0,4
    # since a0 is alread set
    syscall
    # epilog
    lw $31,0($sp)
    addiu $sp,$sp,4
    jr $31

    .globl printresult
printresult:
    # prolog
    addiu $sp,$sp,-4
    sw $31,0($sp)

    li $v0,4
    # since a0 is alread set
    syscall

    li $v0,1
    move $a0,$a1
    # since a0 is alread set
    syscall

    li $v0,4
    la $a0,newline
    syscall

    # epilog
    lw $31,0($sp)
    addiu $sp,$sp,4
    jr $31

    .globl readint
readint:
    # prolog
    addiu $sp,$sp,-8
    sw $31,4($sp)

    li $v0,5
    syscall
    sw $v0,0($sp)

    lw $v0,0($sp)
    lw $31,4($sp)
    addiu $sp,$sp,8
    jr $31

    .globl main
main:
    # prolog
    addiu $29,$29,-24
    #
    # M[sp+16] is for $31
    # M[sp+12] is for divisor
    # M[sp+8]  is for dividend
    # M[sp+4]  is for remainder
    # M[sp+0]  is for quotient
    sw $31,16($29)

    la $a0,msg1
    jalr printmsg

    jalr readint
    sw $v0,8($sp)

    jalr readint
    sw $v0,12($sp)

$L4:
    lw $8,8($sp)  # dividend
    lw $9,12($sp) # divisor

    slti $8,$8,1
    beq $8,$0,$L1  # if dividend > 0 then check divisor > 0
    b $L3          # otherwise exit the loop
$L1:
    slti $9,$9,1
    beq $9,$0,$L2 # if divisor > 0 then enter the loop body
    b $L3         # otherwise exit the loop
$L2:
   # place the translation of the loop body
   #
   #
    lw $8,8($sp)  # dividend
    lw $9,12($sp) # divisor
    div $8,$9     # hi is the result of mod and low has the integer divison
    mflo $a1
    la   $a0,msg2
    jalr printresult
    mfhi $a1
    la   $a0,msg3
    jalr printresult

    la $a0,msg1
    jalr printmsg

    jalr readint
    sw $v0,8($sp)

    jalr readint
    sw $v0,12($sp)

    b $L4 # beginning of the loop

$L3:
    # epilog
    lw $31,16($29)
    addiu $29,$29,24
    jr $31