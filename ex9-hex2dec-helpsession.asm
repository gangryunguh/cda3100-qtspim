   .data
   .align 2
hexstring: .byte      0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
invalid:   .word      0
prompt1:   .asciiz    "Enter a hexadecimal value.\n"
prompt2:   .asciiz    "The hexadecimal number entered is invalid: 0x"
prompt3:   .asciiz    "The hexadecimal number entered is the decimal value: "
newline:   .asciiz    "\n"

   .text
   .align 2
   .globl hextodec
hextodec:
    # stack frame size 20 bytes (5 words)
    # M[sp+16] : return address
    # M[sp+12] : digit
    # M[sp+8]  : length
    # M]sp+4]  : total
    # M[sp]    : t
    addiu $sp,$sp,-20
    sw $31,16($29)
    sw $0,4($sp)
    sw $0,8($sp)

    lb $8,0($a0)
    sb $8,0($sp)
  $L1:
    lb $8,0($sp)
    li $9,'\n'
    beq $8,$9,$L0

    lb $8,0($sp)
    li $9,'0'
    subu $9,$8,$9
    sw $9,12($sp)

    lw   $8,4($sp)
    sll  $8,$8,4
    lw   $9,12($sp)
    addu $8,$8,$9
    sw   $8,4($sp)

     lw $8,8($sp)
     addiu $8,$8,1
     sw $8,8($sp)

     addiu $a0,$a0,1
     lb $8,0($a0)
     sb $8,0($sp)
     b $L1

$L0:
    lw   $v0,4($sp)
    lw   $31,16($sp)
    addiu $sp,$sp,20
    jr $31

   .globl main
  main:
     # stack frame size 20 bytes (5 words)
     # M[sp+4] : return address
     # M[sp]   : value
     addiu $sp,$sp,-8
     sw $31,4($29)

     # print prompt - "Enter a hexadecimal value.\n"
     li     $v0,4
     la     $a0,prompt1
     syscall

      # read the input string into hexstring
      li   $v0,8
      la   $a0,hexstring
      li   $a1,12
      syscall

      # call hextodec() with hexstring as an argument
      la $a0,hexstring
      jal hextodec
      sw $v0,0($sp)


      # print prompt "The hexadecimal number entered is the decimal value:
      li     $v0,4
      la     $a0,prompt3
      syscall

      # print the value
      li    $v0,1
      lw    $a0,0($sp)
      syscall

      # print the newline
      li    $v0,4
      la    $a0,newline
      syscall

      lw $31,4($29)
      addiu $sp,$sp,8
      jr $31

