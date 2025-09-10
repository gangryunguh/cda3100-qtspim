    .data
prompt1: .asciiz "Hello cda3100\n"
    .text
    .globl main
main:
    # allocate activation record for local variables and other
    # temporaries on runtime stack
    addi $29,$29,-4

    # M[$29] is for local variable "num"
    # M[$29+4] is for saving $31
    sw $31,0($29)

    li $2,4
    la $4,prompt1
    syscall

    lw $31,0($29)
    addi $29,$29,4
    jr $31
