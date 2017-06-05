.data 
	str1 : .asciiz "Moi ban nhap n = "
	str2 : .asciiz "sqrt( "
	str3 : .asciiz " ) = "
	str4 : .asciiz "\n"
	const  : .float 0.0
	const1 : .float 0.000001
	const2 : .float 2.0
.text 
.globl main
main:
 	li $v0, 4
	la $a0, str4
	syscall 
	
	li $v0, 4
	la $a0, str1
	syscall 
	
	li $v0, 6
	syscall 
	
	#$f0 = n 
	
	#f1 = dau = 0
	la $t0, const
	l.s $f1, ($t0) 

	#f3 = cuoi = n ; f2 = giua
	#f7 = 0.0
	l.s $f7, ($t0)
	add.s $f3, $f0, $f7
	
	#f8 = 0.0001
	la $t0, const1
	l.s $f8, ($t0)
	
	#f5 = 2.0
	la $t0, const2
	l.s $f5, ($t0)

	while:
		add.s $f2, $f1, $f3
		div.s $f2, $f2, $f5
		#f2 = (dau + cuoi)/2
		mul.s $f4, $f2, $f2 
	        #f4 = f2^2
	        
	        #So sanh f4 voi f0, neu f4 > f0 suy ra cuoi = f2 neu k dau = f2
		c.lt.s $f0, $f4
		bc1t Gancuoichogiua
		j Gandauchogiua
		
		Gancuoichogiua: 
		add.s $f3, $f2, $f7 
		j Tieptuc
		
		Gandauchogiua:
		add.s $f1, $f2, $f7
		j Tieptuc
		
		Tieptuc:
	        sub.s $f9, $f3, $f1 
	        c.lt.s $f9, $f8
	   
	        bc1t Exit
	        j while
	Exit:
	
	#In ket qua ra man hinh 
	li $v0, 4
	la $a0, str2
	syscall 
	
	li $v0, 2
	add.s $f12, $f0, $f7
	syscall 
	
	li $v0, 4
	la $a0, str3 
	syscall 
	
	li $v0, 2
	add.s $f12, $f1, $f7
	syscall 
	
