    .data
    .align 2
prompt1: .asciiz "Enter an integer: "
prompt2: .asciiz "The number you typed is = "
newline: .asciiz "\n"
    .text
    .align 2
    .globl main
main:
    # allocate activation record for local variables and other
    # temporaries on runtime stack
    addi $29,$29,-8

    # M[$29] is for local variable "num"
    # M[$29+4] is for saving $31
    sw $31,4($29)

    li $2,4
    la $4,prompt1
    syscall

    li $2,5
    syscall

    sw $2,0($29)

    li $2,4
    la $4,prompt2
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
