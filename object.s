.data
_Prompt: .asciiz "Enter an integer:  "
_ret: .asciiz "\n"
.globl main
.text
addi $sp,$zero,0x00002ffc
add $t1, $zero, 0x0003310
j main
read:
  li $v0,4
  la $a0,_Prompt
  syscall
  li $v0,5
  syscall
  jr $ra
write:
  li $v0,1
  syscall
  li $v0,4
  la $a0,_ret
  syscall
  move $v0,$0
  jr $ra

fibo:
  li $t3,1
  sw $t3, 16($sp)
  lw $t1, 12($sp)
  lw $t2, 16($sp)
  beq $t1,$t2,label2
  j label3
label3:
  li $t3,2
  sw $t3, 16($sp)
  lw $t1, 12($sp)
  lw $t2, 16($sp)
  beq $t1,$t2,label2
  j label1
label2:
  li $t3,1
  sw $t3, 16($sp)
  lw $v0,16($sp)
  jr $ra
  li $t3,1
  sw $t3, 16($sp)
  lw $t1, 12($sp)
  lw $t2, 16($sp)
  sub $t3,$t1,$t2
  sw $t3, 20($sp)
  move $t0,$sp
  addi $sp, $sp, -44
  sw $ra,0($sp)
  lw $t1, 20($t0)
  move $t3,$t1
  sw $t3,12($sp)
  jal fibo
  lw $ra,0($sp)
  addi $sp,$sp,44
  sw $v0,24($sp)
  li $t3,2
  sw $t3, 28($sp)
  lw $t1, 12($sp)
  lw $t2, 28($sp)
  sub $t3,$t1,$t2
  sw $t3, 32($sp)
  move $t0,$sp
  addi $sp, $sp, -44
  sw $ra,0($sp)
  lw $t1, 32($t0)
  move $t3,$t1
  sw $t3,12($sp)
  jal fibo
  lw $ra,0($sp)
  addi $sp,$sp,44
  sw $v0,36($sp)
  lw $t1, 24($sp)
  lw $t2, 36($sp)
  add $t3,$t1,$t2
  sw $t3, 40($sp)
  lw $v0,40($sp)
  jr $ra
label1:

main:
  addi $sp, $sp, -32
  addi $sp, $sp, -4
  sw $ra,0($sp)
  jal read
  lw $ra,0($sp)
  addi $sp, $sp, 4
  sw $v0, 24($sp)
  lw $t1, 24($sp)
  move $t3, $t1
  sw $t3, 12($sp)
  li $t3,1
  sw $t3, 24($sp)
  lw $t1, 24($sp)
  move $t3, $t1
  sw $t3, 20($sp)
label11:
  lw $t1, 20($sp)
  lw $t2, 12($sp)
  ble $t1,$t2,label10
  j label9
label10:
  move $t0,$sp
  addi $sp, $sp, -44
  sw $ra,0($sp)
  lw $t1, 20($t0)
  move $t3,$t1
  sw $t3,12($sp)
  jal fibo
  lw $ra,0($sp)
  addi $sp,$sp,44
  sw $v0,24($sp)
  lw $t1, 24($sp)
  move $t3, $t1
  sw $t3, 16($sp)
  lw $a0, 16($sp)
  addi $sp, $sp, -4
  sw $ra,0($sp)
  jal write
  lw $ra,0($sp)
  addi $sp, $sp, 4
  li $t3,1
  sw $t3, 24($sp)
  lw $t1, 20($sp)
  lw $t2, 24($sp)
  add $t3,$t1,$t2
  sw $t3, 28($sp)
  lw $t1, 28($sp)
  move $t3, $t1
  sw $t3, 20($sp)
  li $t3,4
  sw $t3, 24($sp)
  lw $t1, 20($sp)
  lw $t2, 24($sp)
  beq $t1,$t2,label15
  j label11
label15:
  j 
  j label11
label9:
  li $t3,0
  sw $t3, 24($sp)
  lw $v0,24($sp)
  jr $ra
label5:
