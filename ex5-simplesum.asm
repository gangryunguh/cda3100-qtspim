    .data
    .align 2
prompt1: .asciiz "The sum of the first 10 natural numbers is: "
newline: .asciiz "\n"

    .text
    .align 2
    .globl main
main:
    # allocate activation record for local variables and other
    # temporaries on runtime stack
    # M[$29+8] is for saving return address from main
    # M[$29+4] is for i
    # M[$29]   is for sum

    addi $29,$29,-12
    sw $31,8($sp)

    sw $zero,0($sp)

    #    initialize i = 0
    # loop:
    #    if i > 10 goto exit
    #.   sum = sum + i
    #.   i = i + 1
    #    goto loop
    # exit:
    #.   printf
    #.   return

    # i = 1
    li $8, 1
    sw $8,4($29)
$loop:
    lw $8,4($29)
    slti $8,$8,11  # $8 = 1 if $8 <= 10, else $8 = 0
    beq $8,$0,$L0  # if $8 == 0, then exit the loop

    # sum += i which is sum = sum + i
    lw $8,0($29) # sum
    lw $9,4($29) # i
    addu $9,$9,$8
    sw $9,0($29)

    lw $8,4($29)
    addiu $8,$8,1
    sw $8,4($29)
    b  $loop
 $L0:
    li $2,4
    la $4,prompt1
    syscall

    li $2,1
    lw $4,0($29)
    syscall

    li $2,4
    la $4,newline
    syscall

    li $v0,0
    lw $31,8($29)
    addi $29,$29,12
    jr $31
