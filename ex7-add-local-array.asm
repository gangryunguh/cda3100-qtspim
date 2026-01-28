    .data
    .align 2
prompt:   .asciiz  "sum = "
newline:  .asciiz  "\n"
    .text
    .align 2
    .globl arraysum
arraysum:











   .globl main
main:
    # M[$29+52] is for $31
    # M[$29+48] is for the compiler generated temporary variable k
    # M[$29+44] is for the compiler generated temporary variable i
    # M[$29+40] is for sum
    # M[$29+0] is to larray[0]
