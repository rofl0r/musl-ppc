        .global sigsetjmp
        .type sigsetjmp,%function
sigsetjmp:
	#int sigsetjmp(sigjmp_buf buf, int save)
#			r3		r4
	#0) store save into buf->__fl
	stw 4, 256(3)
	#1) compare save with 0
	cmpwi cr7, 4, 0
	#2) if its 0, goto setjmp code
	beq- cr7, 1f
	#3) else: we must call pthread_sigmask(SIG_SETMASK, 0, (sigset_t *)buf->__ss);
	# thus store r3 on the stack, to restore it later
	stw 3, -4(1)
	# store old link reg
	mflr 0
	stw 0, -8(1)
	# increase stack frame by 16
	subi 1, 1, 16
	# put pointer to ss buf into r5 (3rd arg)
	addi 5, 3, 260
	# put "2" i.e. SIG_SETMASK in r3
	li 3, 2
	li 4, 0
	bl pthread_sigmask
	#restore sp
	addi 1, 1, 16
	#restore r3
	lwz 3, -4(1)
	#restore link reg
	lwz 0, -8(1)
	mtlr 0
1:
	b setjmp
	
#00000000 <sigsetjmp>:
#   0:   2f 84 00 00     cmpwi   cr7,r4,0
#   4:   7c 08 02 a6     mflr    r0
#   8:   94 21 ff f0     stwu    r1,-16(r1)
#   c:   93 e1 00 0c     stw     r31,12(r1)
#  10:   7c 7f 1b 78     mr      r31,r3
#  14:   90 01 00 14     stw     r0,20(r1)
#  18:   90 83 01 00     stw     r4,256(r3)
#  1c:   41 9e 00 14     beq-    cr7,30 <sigsetjmp+0x30>
#  20:   38 60 00 02     li      r3,2
#  24:   38 80 00 00     li      r4,0
#  28:   38 bf 01 04     addi    r5,r31,260
#  2c:   48 00 00 01     bl      2c <sigsetjmp+0x2c>
#                        2c: R_PPC_REL24 pthread_sigmask
#  30:   7f e3 fb 78     mr      r3,r31
#  34:   48 00 00 01     bl      34 <sigsetjmp+0x34>
#                        34: R_PPC_REL24 setjmp
#  38:   80 01 00 14     lwz     r0,20(r1)
#  3c:   83 e1 00 0c     lwz     r31,12(r1)
#  40:   38 21 00 10     addi    r1,r1,16
#  44:   7c 08 03 a6     mtlr    r0
#  48:   4e 80 00 20     blr

#        lwz     4, 64*4-2*4(3)        # Second last long.
#        cmpi    4, 0, 4, 0
#        bne     4, 1f
#        addi    5, 3, 64*4-1*4        # Address of last long.
#        li      4, 0
#        li      3, 2
#        bl      sigprocmask
#1:      b       setjmp
