#Author: Sotiris Karapiperis
#problem set 1 - exercise 2

#declare data
.data

#source code
.text
.globl main

main:
      addi $a0, $zero, 1 #set first argument = 1
      addi $a1, $zero, 10 #set first argument = 10
      jal sum1 #call sum1(1,10)

      #syscall to print the result
      add $a0 ,$zero, $v0
      li $v0, 1
      syscall

      #syscall to print space character
      li $a0, 32
      li $v0, 11
      syscall

      addi $a0, $zero, 1 #set first argument = 1
      addi $a1, $zero, 10 #set first argument = 10
      jal sum2 #call sum2(1,10)


      #syscall to print the result
      add $a0 ,$zero, $v0
      li $v0, 1
      syscall

      #syscall to exit the program
      li $v0, 10
      syscall

      #a0 = n, a1 = k
sum1:
      add $t2, $zero, $zero #t2 = res = 0
for:  slt $t3, $a1, $a0 # t3 = 1 if n > k
      bne $t3, $zero, end #if n > k jump to end
      add $t2, $t2, $a0 # res += n
      addi $a0, $a0, 1 #n++
      j for #iterate again the loop
end:
      add $v0, $zero, $t2 #copy res to v0
      jr $ra #return to caller


sum2:
      addi $sp, $sp, -8 #make space to stack
      sw $ra, 0($sp) #save ra
      sw $a0, 4($sp) #save n
      slt $t0, $a1, $a0 #t0 = 1 if n > k
      beq $t0, $zero, recur #if n <= k jump to recur
      add $v0, $zero, $zero #if n > k return 0
      addi $sp, $sp, 8 #no need to load ra, a0 just restore stack pointer
      jr $ra #return to caller

recur:addi $a0, $a0, 1 #n +=1
      jal sum2 #call sum2(n + 1 , k)
      lw $a0, 4($sp) #load a0
      lw $ra, 0($sp) #load ra
      addi $sp, $sp, 8 #restore stack pointer
      add $v0, $v0, $a0 # res = n + sum2(n+1, k)
      jr $ra #return to caller


.end main
