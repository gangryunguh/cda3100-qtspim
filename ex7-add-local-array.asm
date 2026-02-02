
     .data
     .align 2
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
    # M[$29+52] is for $31
    # M[$29+48] is for the compiler generated temporary variable k
    # M[$29+44] is for the compiler generated temporary variable i
    # M[$29+40] is for sum
    # M[$29+0] is to larray[0]
    addiu $sp,$sp,-56
    sw    $31,52($sp)  # for $31

    # for (i = 0, k=1; i < 10; i++,k++)
    #     larray[i] = k;
    sw $zero,44($sp) # i = 0
    li $8,1
    sw $8,48($sp)    # k = 1
$L4:
    lw $8,44($sp)
    slti $9,$8,10
    beq $9,$0,$L3

    lw $8,48($sp) # k

    lw $9,44($sp)
    sll $9,$9,2
    addu $10,$29,$9
    sw $8,0($10)

    lw $8,44($sp)
    addiu $8,$8,1
    sw $8,44($29)
    lw $8,48($sp)
    addiu $8,$8,1
    sw $8,48($29)
    b $L4
$L3:
      move     $a0,$sp
       li     $a1,10
       jal    arraysum

       move   $t0,$v0
       # print prompt
       li     $v0,4
       la     $a0,prompt
       syscall

       li     $v0,1
       move  $a0,$t0
       syscall

       # print the newline
       li    $v0,4
       la    $a0,newline
       syscall

       # epilog
       lw    $31,52($sp)
       addiu $sp,$sp,56
       jr    $ra
