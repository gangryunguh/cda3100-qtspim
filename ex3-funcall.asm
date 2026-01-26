    .data
    .align 2
array:    .word    0, 0, 0, 0, 0, 0, 0, 0, 0, 0
prompt:   .asciiz  "x = "
newline:  .asciiz  "\n"

    .text
    .align 2
    .globl bar
bar:
    addiu $sp,$sp,-8
    sw $31,4($sp)

    addu $8,$a0,$a1 # $8 = $a0 + $a1
    addu $8,$8,$a2
    sw $8,0($sp)

    lw $8,0($sp)
    addi $8,$8,6
    sw $8,0($sp)

    addu $v0,$8,$0
    lw $31,4($sp)
    addiu $sp,$sp,8
    jr $31

    .globl main
main:
    addiu $sp,$sp,-16
    sw $31,12($sp)
    li $8,1
    sw $8,0($sp)
    li $8,2
    sw $8,4($sp)
    li $8,3
    sw $8,8($sp)

    lw $a0,0($sp)
    lw $a1,4($sp)
    lw $a2,8($sp)
    jal bar

    sw $v0,0($sp)

    lw $8,0($sp)
    la $9,array
    li $10,5
    sll $10,$10,2
    addu $9,$9,$10
    sw $8,0($9)

    # print prompt
    li     $v0,4
    la     $a0,prompt
    syscall

    li     $v0,1
    lw     $a0,0($sp)
    syscall

    # print the newline
    li    $v0,4
    la    $a0,newline
    syscall

    li    $v0,0
    lw    $31,12($sp)
    addiu $sp,$sp,16
    jr    $31