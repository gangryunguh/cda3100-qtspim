   .data
prompt1: .asciiz "The sum of the first 10 natural numbers is: "
newline: .asciiz "\n"
    .align 2
    .text
    .globl main
main:
    # allocate activation record for local variables and other
    # temporaries on runtime stack
    addiu $29,$29,-12
    sw $31,8($29)

    # M[$29] is for local variable "sum"
    # M[$29+4] is for local variable "i"
    sw $0,0($29)

    # i = 1
    addiu $8,$0,1
    sw $8,4($29)

$L0:
    # i <= 10
    lw $8,4($29)
    slti $9,$8,11
    beq $9,$0,$L1

    lw $10,0($29)
    lw $11,4($29)
    addu $10,$10,$11
    sw $10,0($29)

    lw $10,4($29)
    addiu $10,$10,1
    sw $10,4($29)
    b $L0
$L1:
    li $2,4
    la $4,prompt1
    syscall

    # print sum
    li $2,1
    lw $4,0($29)
    syscall

    li $2,4
    la $4,newline
    syscall

    lw $31,8($29)
    addiu $29,$29,12
    jr $31
