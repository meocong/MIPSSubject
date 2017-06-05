.data 
	str1: .asciiz "Moi ban nhap xau : "
	str2: .asciiz "Ket qua sau khi chuyen chu thuong sang chu hoa : "
	str3: .asciiz "\n"
	s   : .space  200

.text 
.globl main
main:
        li $v0, 4
        la $a0, str3
        syscall 
	li $v0, 4
	la $a0, str1
	syscall 
	
	 #Doc xau 
	 li $v0, 8 
	 la $a0, s
	 li $a1, 196
	 syscall 
	 
	 #s0 : dia chi s 
	 #$s1 : do dai xau 
	 la $s0, s
	 
	 #Chuyen xau sang in hoa va in ra 
	 
	 loop:
	 	lb $a0, 0($s0)
	 	beqz $a0, Exit
	 	
	 	addi $t0, $a0, -97
	 	bgez $t0, Chuyensanginhoa
	 	j Khongchuyensanginhoa
	 	Chuyensanginhoa:
	 	addi $t0, $a0, -32
	 	sb $t0, 0($s0)
                Khongchuyensanginhoa:
	 	addi $s0, $s0, 1
	        j loop
	 Exit: 
         
         li $v0, 4 
         la $a0, str2
         syscall 
         li $v0, 4
         la $a0, s
         syscall 