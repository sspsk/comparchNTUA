.data
.text
.globl main

main:
      addi $a0, $zero, 1
      addi $a1, $zero, 10
      #jal sum1
      jal sum2
      add $t0, $zero, $v0#save the result, $v0 gets altered by syscall
      li $v0, 10
      syscall

sum1:
      add $t0, $a0, $zero
      add $t1, $a1, $zero
      add $t2, $zero, $zero
for:  slt $t3, $t1, $t0
      bne $t3, $zero, end
      add $t2, $t2, $t0
      addi $t0, $t0, 1
      j for
end:
      add $v0, $zero, $t2
      jr $ra


sum2:
      addi $sp, $sp, -8
      sw $ra, 0($sp)
      sw $a0, 4($sp)
      slt $t0, $a1, $a0
      beq $t0, $zero, recur
      add $v0, $zero, $zero
      addi $sp, $sp, 8
      jr $ra

recur:addi $a0, $a0, 1
      jal sum2
      lw $a0, 4($sp)
      lw $ra, 0($sp)
      addi $sp, $sp, 8
      add $v0, $v0, $a0
      jr $ra


.end main
