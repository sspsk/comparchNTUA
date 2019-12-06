.data
msg: .asciiz "Does not exist!"
.text
.globl main

main:
      add $a0, $zero, $zero #root = NULL
      addi $a1, $zero, 5 # key to insert = 5
      jal insert #call insert(root,5)
      add $a0, $v0, $zero #root = insert(root,5)
      addi $a1, $zero, 15 #key to insert = 15
      jal insert #call insert(root , 15)
      add $a0, $v0, $zero #root = insert(root,15)
      addi $a1, $zero, 10 #key to search = 10
      jal bst #call bst_search(root,10)
      beq $v0, $zero, print #if bst_search == NULL jump to print

      #syscall to print the output
      lw $a0, 0($v0)
      li $v0, 1
      syscall

      j exit #jump to exit

      #syscall to print msg string
print:la $a0, msg
      li $v0, 4
      syscall

      #syscall to exit the program
exit: li $v0, 10
      syscall

      #struct includes 3 32bit words ,total 12 bytes
      #a0  ==  root adress
      #a1  == key
bst:  addi $sp, $sp, -4 #make space to stack
      sw $ra, 0($sp) #store ra
      beq $a0, $zero, ret1 #if root == NULL jump to ret1
      lw $t0, 0($a0) # t0 = root->key
      beq $t0, $a1, ret1 #if root->key == key jump to ret1
      slt $t1, $t0, $a1 #t1 = 1 if root->key < key
      beq $t1, $zero, ret2#if root->key >= key
      lw $t2, 8($a0) #t2 = root->left
      add $a0, $t2, $zero #a2 = t2
      jal bst #call bst(root->left, key)
      lw $ra, 0($sp) # load ra
      addi $sp, $sp, 4 #restore stack pointer
      jr $ra #result already in $v0, return to caller

ret2: lw $t2, 4($a0) #t2 = root->right
      add $a0, $zero, $t2 #a0 = t2
      jal bst #call bst_search(root->right, key)
      lw $ra, 0($sp) #load ra
      addi $sp, $sp, 4 #restore stack pointer
      jr $ra ##result already in $v0,return to caller

ret1: add $v0, $zero, $a0 #return root
      addi $sp, $sp, 4 #no need to load ra,just restore stack pointer
      jr $ra #return to caller

insert:
      addi $sp, $sp, -12 #make some space to stack
      sw $ra, 0($sp) #store ra
      sw $a0, 4($sp) #store a0 = root
      sw $a1, 8($sp) #store a1 = key
      beq $a0, $zero, ret3 #if root = NULL jump to ret3
      lw $t0, 0($a0) #t0 = root->key
      slt $t1, $a1, $t0 #t1 = 1 if key < root->key
      beq $t1, $zero, ret4 #key > root->key jump to ret4
      lw $t1, 4($a0) #t1 = root->left
      add $a0, $zero, $t1 #a0 = t1
      jal insert #call insert(root->left, key)
      lw $a0, 4($sp) #load a0
      sw $v0, 4($a0) #root->left = insert(root->left, key)

      j end #jump to end

ret4: lw $t1, 8($a0) #t1 = root->right
      add $a0, $t1, $zero #a0 = t1
      jal insert #call insert(root->right, key)
      lw $a0, 4($sp) #load a0
      sw $v0, 8($a0) #root->right = insert(root->right, key)
      j end #jump to end

ret3:
      #syscall to allocate memory, 12 bytes
      addi $v0, $zero, 9
      addi $a0, $zero, 12
      syscall


      lw $ra, 0($sp) #load ra
      lw $a1, 8($sp) #load root
      sw $a1, 0($v0) #root->key = key
      sw $zero, 4($v0) #root->left = NULL
      sw $zero, 8($v0) #root->right = NULL
      addi $sp, $sp, 12 #restore stack pointer
      jr $ra #root already in v0,return to caller

end: lw $ra, 0($sp) #load ra
     addi $sp, $sp, 12 #restore stack pointer
     add $v0, $a0, $zero #root in v0
     jr $ra #return to caller




.end main
