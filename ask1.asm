.data
num1: .word 50, 0, 100, 150, 90, 77, 1, 80, 121, 500
.text
.globl main

main:
      la $s0, num1
      add $t0, $s0, $zero
      addi $t1, $zero, 100
      addi $t2, $zero, 10
      sll $t2, $t2, 2
      add $t2, $t2, $s0
while:slt $t3, $t0, $t2
      beq $t3, $zero, end
      lw $t3, 0($t0)
      slt $t4, $t3, $t1
      beq $t4, $zero, else
      add $t4, $t3, $t1
      sw $t4, 0($t0)
      j incr

else: addi $t4, $t3, -1
      sw $t4, 0($t0)

incr: addi $t0, $t0, 4
      j while



end:
      li  $v0, 10
      syscall

.end main
