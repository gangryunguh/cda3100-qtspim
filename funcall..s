    .data
array:    .word    0, 0, 0, 0, 0, 0, 0, 0, 0, 0
prompt:   .asciiz  "x = "
newline:  .asciiz  "\n"
    .align 2
    .text
    .align 2
    .globl bar
bar:
    addiu $sp,$sp,-4  # 4 bytes in M[$sp] for local variable 'x'
    addu  $t0,$a0,$a1
    addu  $t0,$t0,$a2
    sw    $t0,0($sp)
    lw    $t0,0($sp)
    addiu $t0,$t0,6
    sw    $t0,0($sp)
    lw    $v0,0($sp)
    addiu $sp,$sp,4
    jr    $ra

    .globl main
main:
    addiu $sp,$sp,-16 # 12 bytes for local variables 'x','y','z', and saving $ra
    sw    $ra,12($sp)
    addiu  $t0,$zero,1
    sw     $t0,0($sp)
    addiu  $t0,$zero,2
    sw     $t0,4($sp)
    addiu  $t0,$zero,3
    sw     $t0,8($sp)
    lw     $a0,0($sp)
    lw     $a1,4($sp)
    lw     $a2,8($sp)
    jal    bar

    la     $t0,array
    li     $t1,5
    sll    $t1,$t1,2
    addu   $t0,$t0,$t1
    sw     $v0,0($t0)

    addu   $t0,$zero,$v0
    # print prompt
    li     $v0,4
    la     $a0,prompt
    syscall

    li     $v0,1
    addu  $a0,$zero,$t0
    syscall

    # print the newline
    li    $v0,4
    la    $a0,newline
    syscall

    li    $v0,0
    lw    $ra,12($sp)
    addiu $sp,$sp,16
    jr    $ra
