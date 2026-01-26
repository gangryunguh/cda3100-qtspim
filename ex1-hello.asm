      .data
prompt1:   .asciiz "Hello cda3100\n"
      .align 2
      .text
      .globl main
main:
     addiu $29,$29,-4
     sw   $31,0($29)

     li   $2,4
     la  $4,prompt1
     syscall
     li $4, 0

     lw  $31,0($29)
     addiu $29,$29,4
     jr $31

