intp1:
bne $sp,$0,begin1
sw $sp,0x00000800
addi $sp,$sp,0x00000800
begin1:
sw $sp,0($sp)
addi $sp,$sp,-4
sw $1,0($sp)
addi $sp,$sp,-4 #�����ֳ�
sw $s1,0($sp)
addi $sp,$sp,-4
sw $a0,0($sp)
addi $sp,$sp,-4
sw $v0,0($sp)

addi $sp,$sp,-4
mfc0 $1,$1 #inm
nop
nop
sw $1,0($sp)
addi $sp,$sp,-4
mfc0 $1,$2 #epc
nop
nop
sw $1,0($sp)

addi $1,$0,1
mtc0 $1,$1 #INM <= 001
addi $1,$0,1
mtc0 $1,$0 #IE <= 1

addi $s1,$zero,1     #                �������Ʋ��� 
sll $s1, $s1, 28   #�߼�����31λ $s1=0x80000000

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  


add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  


sra $s1, $s1, 4    #0XF0000000-->0XFF000000

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  


sra $s1, $s1, 4    #0XFF000000-->0XFFF00000

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  


sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  


sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  


sra $s1, $s1, 4    


add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex



mtc0 $0,$0 #IE <= 0

lw $1,0($sp)
mtc0 $1,$2 #ecp
addi $sp,$sp,4
lw $1,0($sp)
mtc0 $1,$1 #inm
addi $sp,$sp,4
lw $v0,0($sp) #�ָ��ֳ�
addi $sp,$sp,4
lw $a0,0($sp)
addi $sp,$sp,4
lw $s1,0($sp)
addi $sp,$sp,4
lw $1,0($sp)
addi $sp,$sp,4
lw $sp,0($sp)

addi $30,$0,1
eret
mtc0 $30,$0 #IE <= 1


intp2:
bne $sp,$0,begin2
sw $sp,0x00000800
addi $sp,$sp,0x00000800
begin2:
sw $sp,0($sp)
addi $sp,$sp,-4
sw $1,0($sp)
addi $sp,$sp,-4 #�����ֳ�
sw $s1,0($sp)
addi $sp,$sp,-4
sw $a0,0($sp)
addi $sp,$sp,-4
sw $v0,0($sp)

addi $sp,$sp,-4
mfc0 $1,$1 #inm
nop
nop
sw $1,0($sp)
addi $sp,$sp,-4
mfc0 $1,$2 #epc
nop
nop
sw $1,0($sp)

addi $1,$0,2
mtc0 $1,$1 #INM <= 010
addi $1,$0,1
mtc0 $1,$0 #IE <= 1

addi $s1,$zero,2     #                �������Ʋ��� 
sll $s1, $s1, 28   #�߼�����31λ $s1=0x80000000

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  


add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  


sra $s1, $s1, 4    #0XF0000000-->0XFF000000

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  


sra $s1, $s1, 4    #0XFF000000-->0XFFF00000

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  


sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  


sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  


sra $s1, $s1, 4    


add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex



mtc0 $0,$0 #IE <= 0

lw $1,0($sp)
mtc0 $1,$2 #ecp
addi $sp,$sp,4
lw $1,0($sp)
mtc0 $1,$1 #inm
addi $sp,$sp,4
lw $v0,0($sp) #�ָ��ֳ�
addi $sp,$sp,4
lw $a0,0($sp)
addi $sp,$sp,4
lw $s1,0($sp)
addi $sp,$sp,4
lw $1,0($sp)
addi $sp,$sp,4
lw $sp,0($sp)

addi $30,$0,1
eret
mtc0 $30,$0 #IE <= 1


intp3:
bne $sp,$0,begin3
sw $sp,0x00000800
addi $sp,$sp,0x00000800
begin3:
sw $sp,0($sp)
addi $sp,$sp,-4
sw $1,0($sp)
addi $sp,$sp,-4 #�����ֳ�
sw $s1,0($sp)
addi $sp,$sp,-4
sw $a0,0($sp)
addi $sp,$sp,-4
sw $v0,0($sp)

addi $sp,$sp,-4
mfc0 $1,$1 #inm
nop
nop
sw $1,0($sp)
addi $sp,$sp,-4
mfc0 $1,$2 #epc
nop
nop
sw $1,0($sp)

addi $1,$0,4
mtc0 $1,$1 #INM <= 100
addi $1,$0,1
mtc0 $1,$0 #IE <= 1

addi $s1,$zero,3     #                �������Ʋ��� 
sll $s1, $s1, 28   #�߼�����31λ $s1=0x80000000

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  


add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  


sra $s1, $s1, 4    #0XF0000000-->0XFF000000

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  


sra $s1, $s1, 4    #0XFF000000-->0XFFF00000

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  

sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  


sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  


sra $s1, $s1, 4    

add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex
syscall                 # we are out of here.  


sra $s1, $s1, 4    


add    $a0,$0,$s1       #display $s1
addi   $v0,$0,34         # display hex



mtc0 $0,$0 #IE <= 0

lw $1,0($sp)
mtc0 $1,$2 #ecp
addi $sp,$sp,4
lw $1,0($sp)
mtc0 $1,$1 #inm
addi $sp,$sp,4
lw $v0,0($sp) #�ָ��ֳ�
addi $sp,$sp,4
lw $a0,0($sp)
addi $sp,$sp,4
lw $s1,0($sp)
addi $sp,$sp,4
lw $1,0($sp)
addi $sp,$sp,4
lw $sp,0($sp)

addi $30,$0,1
eret
mtc0 $30,$0 #IE <= 1
