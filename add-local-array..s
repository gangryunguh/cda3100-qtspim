    .data
prompt:   .asciiz  "sum = "
newline:  .asciiz  "\n"
    .align 2
    .text
    .globl arraysum
arraysum:
    # function prolog
    # M[$29+8] is to save/restore return address
    addiu $sp,$sp,-12
    sw    $31,8($sp)

    # M[$29+4] is for i
    # M[$29]   is for sum
    lw $0,0($29)  # sum = 0
    slti  $8,$a1,1
    bne   $8,$0,$L1

    sw $0,4($29)
$L0:
    lw $8,4($29)
    slt $8,$8,$a1
    beq $8,$0,$L1

    # sum = sum + arr[i]
    lw $8,0($29)   # sum
    lw $9,4($29)   # i
    sll $9,$9,2    # arr[i] : &(arr[0])+ i * 4 => &(arr[0]) + (i << 2)
    addu $9,$a0,$9
    lw $9,0($9)    # $9 = arr[i]
    addu  $8,$8,$9
    sw $8,0($29)   # sum =

    lw $8,4($29)   # i
    addiu $8,$8,1
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
    addiu $sp,$sp,-48
    sw    $31,44($sp)

    # M[$29+4] is to larray[0]
    # M[$29]   is for sum

    # we need
    # for (i = 0, k=1; i < 10; i++,k++)
    #     larray[i] = k;
    li $8,0
    li $9,1
    addiu $10,$sp,4  # &(larray[0])
$L4:
    slti $11,$8,10
    beq $11,$0,$L3

    # larray[i] = k
    # larray[i] = &(larray[0])+ i*4
    sll $12,$8,2
    addu $12,$10,$12
    sw $9,0($12)

    addiu $8,$8,1
    addiu $9,$9,1
    b $L4

$L3:
    move     $a0,$10
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
    lw    $31,44($sp)
    addiu $sp,$sp,48
    jr    $ra
