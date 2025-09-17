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

    # M[$29+8] is for $31 (return address)
    # M[$29+4] is for saving i
    # M[$29] is for local variable "sum"

    sw $31,8($29)

    sw $0,0($29)

     # i = 1
    li $8, 1
    sw $8,4($29)

$L1:
     # i <= 10
     lw $8,4($29)
     slti $8,$8,11  # $8 = 1 if $8 <= 10, else $8 = 0
     beq $8,$0,$L0  # if $8 == 0, then exit the loop

     # sum += i which is sum = sum + i
     lw $8,4($29)
     lw $9,0($29)
     addu $9,$9,$8
     sw $9,0($29)

     lw $8,4($29)
     addiu $8,$8,1
     sw $8,4($29)
     b  $L1
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

     lw $31,8($29)
     addi $29,$29,12
     jr $31
