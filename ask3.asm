.data
msg: .asciiz "Does not exist!"
.text
.globl main

main:
      add $a0, $zero, $zero
      addi $a1, $zero, 5
      jal insert
      add $a0, $v0, $zero
      addi $a1, $zero, 15
      jal insert
      add $a0, $v0, $zero
      addi $a1, $zero, 10
      jal bst
      beq $v0, $zero, print
      lw $a0, 0($v0)
      li $v0, 1
      syscall
      j exit

print:la $a0, msg
      li $v0, 4
      syscall

exit: li $v0, 10
      syscall
      #a0  ==  root adress
      #a1  == key
      #struct includes 3 32bit words ,total 12 bytes
bst:  addi $sp, $sp, -4
      sw $ra, 0($sp)
      beq $a0, $zero, ret1
      lw $t0, 0($a0) # root->key
      beq $t0, $a1, ret1
      slt $t1, $t0, $a1
      beq $t1, $zero, ret2
      lw $t2, 8($a0)
      add $a0, $t2, $zero
      jal bst
      lw $ra, 0($sp)
      addi $sp, $sp, 4
      jr $ra #result already in $v0

ret2: lw $t2, 4($a0)
      add $a0, $zero, $t2
      jal bst
      lw $ra, 0($sp)
      addi $sp, $sp, 4
      jr $ra ##result already in $v0

ret1: add $v0, $zero, $a0
      addi $sp, $sp, 4
      jr $ra

insert:
      addi $sp, $sp, -12
      sw $ra, 0($sp)
      sw $a0, 4($sp)
      sw $a1, 8($sp)
      beq $a0, $zero, ret3
      lw $t0, 0($a0)
      slt $t1, $a1, $t0
      beq $t1, $zero, ret4
      lw $t1, 4($a0)
      add $a0, $zero, $t1
      jal insert
      lw $a0, 4($sp)
      sw $v0, 4($a0)

      j end

ret4: lw $t1, 8($a0)
      add $a0, $t1, $zero
      jal insert
      lw $a0, 4($sp)
      sw $v0, 8($a0)
      j end

ret3: addi $v0, $zero, 9
      addi $a0, $zero, 12
      syscall
      lw $ra, 0($sp)
      lw $a1, 8($sp)
      sw $a1, 0($v0)
      sw $zero, 4($v0)
      sw $zero, 8($v0)
      addi $sp, $sp, 12
      jr $ra

end: lw $ra, 0($sp)
     addi $sp, $sp, 12
     add $v0, $a0, $zero
     jr $ra




.end main
