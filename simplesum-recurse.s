   .data
prompt1: .asciiz "The sum of the first 10 natural numbers is: "
newline: .asciiz "\n"
    .align 2
    .text
    .globl partialsum

partialsum:
    # M[$29+8] is to save $31
    # M[$29+4] is to save $a0
    # M[$29] is for a local variable sum

    addiu $29,$29,-12
    sw $31,8($29)
    sw $a0,4($29)

    slt $8,$a0,2
    bne $8,$0,$L1
    # i >= 2, we need to recurse
    addi $a0,$a0,-1
    jal partialsum

    sw $v0,0($29)

    lw $8,0($29)
    lw $9,4($29)
    addu $v0,$8,$9

    lw $a0,4($29)
    lw $31,8($29)
    addiu $29,$29,12
    jr $31
$L1:
    li $v0,1
    lw $a0,4($29)
    lw $31,8($29)
    addiu $29,$29,12
    jr $31

    .globl main
main:
    # allocate activation record for local variables and other
    # temporaries on runtime stack
    # M[$29+8] is for saving return address from main
    # M[$29+4] is for i
    # M[$29]   is for sum

    addi $29,$29,-8

    # M[$29+4] is for $31 (return address)
    # M[$29] is for local variable "sum"

    sw $31,4($29)

    li $a0, 20
    jal partialsum

    sw $v0,0($29)

    li $2,4
    la $4,prompt1
    syscall

    li $2,1
    lw $4,0($29)
    syscall

    li $2,4
    la $4,newline
    syscall

    lw $31,4($29)
    addi $29,$29,8
    jr $31
