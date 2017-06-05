.data 
	str1: .asciiz "Moi nhap so phan tu cua mang : n = "
	str2: .asciiz "Moi nhap phan tu thu "
	str3: .asciiz " : "
	str4: .asciiz "Gia tri lon thu "
	str7: .asciiz " cua mang la : "
	str5: .asciiz "Do n<=0 nen thoat chuong trinh"
	str6: .asciiz "\n"
	str8: .asciiz "Moi nhap k = "
	str9: .asciiz "Khong ton tai phan tu lon thu k trong mang"
	A   : .word 0:100
	n   : .word 0
	k   : .word 0
	
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
	
	#Nhap k 
	li $v0, 4
	la $a0, str8
	syscall 
	li $v0, 5
	syscall 
	la $a0, k 
	sw $v0, 0($a0)
	
	#$s0, luu vi tri A[1]
	la $s0, A
	addi $s0, $s0, 4
	
	#$s1, bien chay i
	addi $s1, $0, 1
	
	#Doc n phan tu 
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

		#i = i+1 
	        addi $s1, $s1, 1
	        
 		j loop
        Exit:
        
        #Sap xep mang A[1->n] bang thuat toan noi bot 
        #$s0 = dia chi A[i]
        la $s0, A
        addi $s0, $s0, 4 #A[1]
        #$s3 = i + 1
        addi $s3, $0, 2 
        #$s5 = n 
        la $a0, n 
        lw $s5, 0($a0)
        
        
        loop1:
        	subu $t0, $s3, $s5
        	bgtz $t0, Exit1
        	
        	#$s1 = dia chi A[i+1]
        	addi $s1, $s0, 4
        	#$s4 = j
        	addi $s4, $s3, 0
        	loop2:
        		subu $t0, $s4, $s5
        		bgtz $t0, Exit2
        		
        		lw $t0, 0($s0) #$t0 = A[i]
        		lw $t1, 0($s1) #$t1 = A[j]
        		#if A[i] < A[j] -> doi cho A[i], A[j] 
        		subu $t2, $t1, $t0
        		bgtz $t2, Doicho
        		j Khongdoicho
        		Doicho: 
        		addi $t3, $t0, 0
        		addi $t0, $t1, 0
        		addi $t1, $t3, 0
        		sw $t0, 0($s0)
        		sw $t1, 0($s1)
        		Khongdoicho: 
        		
        		addi $s1, $s1, 4
        		addi $s4, $s4, 1
        		j loop2
        	Exit2:
 	
        	addi $s0, $s0, 4
        	addi $s3, $s3, 1  
        	j loop1
        Exit1:
        
        #Tim phan tu lon thu k 
        #$s6 = k 
        la $a0, k
        lw $s6, 0($a0)
        
        la $s0, A
        la $t0, A 
        addi $s0, $s0, 4 #A[1]
        lw $t1, 0($s0)
        addi $t1, $t1, 1
        sw $t1, 0($t0) #A[0] = A[1] + 1
        lw $s2, 0($s0) #result = $s2 
        
        addi $s3, $0, 2 #i
        addi $s4, $0, 1 #A[i] #Phan tu lon thu s4
        loop3:
        	subu $t0, $s3, $s5
        	bgtz $t0, Exit3
        	addi $s1, $s0, 0 #dia chi A[i-1]
        	addi $s0, $s0, 4 #dia chi A[i]
        	
        	#Neu A[i]<A[i-1] thi tang s4 
        	lw $t0, 0($s0)
        	lw $t1, 0($s1)
        	subu $t2, $t1, $t0
        	bgtz $t2, Tangs4
                j Khongtangs4
                Tangs4:
        	addi $s4, $s4, 1
        	Khongtangs4:
        	
        	#Neu s4 = s6 thi gan s2 = A[i]
                subu $t1, $s4, $s6 
                beq $t1, $0, Gangiatrilonthuk
                j Khonggangiatrilonthuk
                Gangiatrilonthuk:
                addi $s2, $t0, 0
                Khonggangiatrilonthuk:
                
        	addi $s3, $s3, 1
        	j loop3
        Exit3:
        
        #li $v0, 1
        #addi $a0, $s4, 0
        #syscall
        #Neu ton tai phan tu lon thu k thi in ra khong thi bao khong ton tai 
        subu $t0, $s4, $s6
        bgez $t0, Inraketqua
        j Khongtontaiketqua
        Inraketqua:
        li $v0, 4
        la $a0, str4
        syscall 
        li $v0, 1
        addi $a0, $s6, 0
        syscall 
        li $v0, 4
        la $a0, str7
        syscall 
        li $v0, 1
        addi $a0, $s2, 0
        syscall 
        j Exitall
	
	Exitnlessthan1: 
	li $v0, 4
	la $a0, str5
	syscall 
	j Exitall
	
	Khongtontaiketqua: 
	li $v0, 4
        la $a0, str9
        syscall 
	Exitall: