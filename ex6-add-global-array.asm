    .data
    .align 2
garray:   .word    1, 2, 3, 4, 5, 6, 7, 8, 9, 10
prompt:   .asciiz  "sum = "
newline:  .asciiz  "\n"
    .text
    .align 2
    .globl arraysum
arraysum:
   # function prolog
    # M[$29+8] is to save/restore return address
    addiu $sp,$sp,-12
    sw    $31,8($sp)

    # M[$29+4] is for i
    # M[$29]   is for sum
    sw $0,0($29)  # sum = 0
    slti  $8,$a1,0
    bne   $8,$0,$L1

    sw $0,4($sp)
 $L0:
    lw $8,4($29)   # i
    slt $8, $8,$a1
    beq $8, $0,$L1

    lw $8,0($29)   # sum
    lw $9,4($29)   # i
    sll $9,$9,2
    addu $9,$9,$a0
    lw $9,0($9)
    addu $8,$8,$9
    sw $8,0($29)
    lw $8,4($29)
    addi $8,$8,1
    sw $8,4($29)
    b $L0

$L1:
    # load sum to $v0 register
    lw $v0,0($29)

    # function epilog
    lw    $31,8($sp)
    addiu $sp,$sp,12
    jr    $ra


   .globl main
main:
    # function prolog
    addiu $sp,$sp,-8
    sw    $31,4($sp)

    # M[$29+4] is to save/restore return address
    # M[$29]   is for local variable sum
    la     $a0,garray
    li     $a1,10
    jal    arraysum

    sw $v0,0($29)

    # print prompt
    li     $v0,4
    la     $a0,prompt
    syscall

    li     $v0,1
    lw    $a0,0($sp)
    syscall

    # print the newline
    li    $v0,4
    la    $a0,newline
    syscall

    li    $v0,0

    # epilog
    lw    $31,4($sp)
    addiu $sp,$sp,8
    jr    $ra


