
#declare data
.data
#array of integers
num1: .word 50, 0, 100, 150, 90, 77, 1, 80, 121, 500

#source code
.text

.globl main

main:
      la $s0, num1 #get address of array
      add $t0, $s0, $zero  #copy address from s0 to t0
      addi $t1, $zero, 100 #load 100 in t1
      addi $t2, $zero, 10 #load 10 in t2
      sll $t2, $t2, 2  #multiply by 4 cause 1 int = 4 bytes
      add $t2, $t2, $s0 #t2 now points to A[10] = s0 + 40
while:slt $t3, $t0, $t2 #t3 = 1 if p < end
      beq $t3, $zero, end #if p >= end exit loop
      lw $t3, 0($t0) #load the A[i] integer
      slt $t4, $t3, $t1 #t4 = 1 if *p < 100
      beq $t4, $zero, else #if *p >= 100 jump to else
      add $t4, $t3, $t1 #if *p < 100 then *p += 100
      sw $t4, 0($t0) #store that back in memory
      j incr #jump to incr

else: addi $t4, $t3, -1 #if *p >= 100 *p -= 1
      sw $t4, 0($t0) #store that back in memory

incr: addi $t0, $t0, 4 #increment t0 by 4 so it points to next element
      j while # iterate again the loop


      #system call to exit the program
end:
      li  $v0, 10
      syscall

.end main
