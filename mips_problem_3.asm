.data 
	str1: .asciiz "Moi nhap so phan tu cua mang : n = "
	str2: .asciiz "Moi nhap phan tu thu "
	str3: .asciiz " : "
	str4: .asciiz "Gia tri lon nhat cua mang la : "
	str5: .asciiz "Do n<=0 nen thoat chuong trinh"
	str6: .asciiz "\n"
	A   : .word 0:100
	n   : .word 0
	
.text 
.globl main
main:
        #Xuong dong 
        li $v0, 4
        la $a0, str6
        syscall 
	#nhap n 
	li $v0, 4
	la $a0, str1
	syscall
	li $v0, 5
	syscall
	la $a0, n
	sw $v0, 0($a0)
	blez $v0, Exitnlessthan1
	#$s0, luu vi tri A[1]
	la $s0, A
	addi $s0, $s0, 4
	
	#$s1, bien chay i
	addi $s1, $0, 1
	
	#Doc phan tu thu 1
	#In ra man hinh: Moi ban nhap phan tu thu 1 : 
	li $v0, 4
	la $a0, str2
	syscall 
	li $v0, 1
	addi $a0, $s1, 0
	syscall
	li $v0, 4
	la $a0, str3
	syscall
	#Doc gia tri vao $v0 luu vao 0($s0) : A[1]
	li $v0, 5
	syscall 
	sw $v0, 0($s0)
	
	#$s2 = A[1] (luu max)
	addi $s2, $v0, 0
	#i = i+1
	addi $s1, $s1, 1
	
	loop:   
	        #Neu $s1 > n , thoat
		la $a0, n
		lw $t0, 0($a0)
		subu $t1, $s1, $t0
		bgtz $t1, Exit
		
		#Doc A[i]
		li $v0, 4
		la $a0, str2
		syscall 
		li $v0, 1
	        addi $a0, $s1, 0
		syscall
		li $v0, 4
		la $a0, str3
		syscall
		
		#Doc gia tri luu vao A[i] , $t0: dia chi A[i]
		li $v0, 5
		syscall 
		sw $v0, 0($s0)
		addi $s0, $s0, 4
		
		#$s2 = max($s2, A[i])
		subu $t0, $v0, $s2
		bgtz $t0, Gangiatrimax
		j Khonggangiatrimax
		Gangiatrimax: addi $s2, $v0, 0
		Khonggangiatrimax: 
		
		#i = i+1 
	        addi $s1, $s1, 1
	        
 		j loop
        Exit:
        
        #In dap an ra man hinh 
        li $v0, 4
        la $a0, str4
        syscall 
        li $v0, 1
        addi $a0, $s2, 0
        syscall 
        j Exitall         
	
	Exitnlessthan1: 
	li $v0, 4
	la $a0, str5
	syscall 
	
	Exitall:
