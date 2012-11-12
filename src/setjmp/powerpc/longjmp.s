        .global _longjmp
        .global longjmp
        .type   _longjmp,@function
        .type   longjmp,@function
_longjmp:
longjmp:
# void longjmp(jmp_buf env, int val);
# put val into return register and restore the env saved in setjmp
# if val(r4) is 0, put 1 there.
	# 0) move old return address into r0
	lwz 0, 0(3)
	# 1) put it into link reg
	mtlr 0
	#2 ) restore stack ptr
	lwz 1, 4(3)
	#3) restore control reg
	lwz 0, 8(3)
	mtcr 0
	#4) restore r14-r31
	lwz 14, 12(3)
	lwz 15, 16(3)
	lwz 16, 20(3)
	lwz 17, 24(3)
	lwz 18, 28(3)
	lwz 19, 32(3)
	lwz 20, 36(3)
	lwz 21, 40(3)
	lwz 22, 44(3)
	lwz 23, 48(3)
	lwz 24, 52(3)
	lwz 25, 56(3)
	lwz 26, 60(3)
	lwz 27, 64(3)
	lwz 28, 68(3)
	lwz 29, 72(3)
	lwz 30, 76(3)
	lwz 31, 80(3)
	#5) put val into return reg r3
	mr 3, 4

	#6) check if return value is 0, make it 1 in that case
	cmpwi cr7, 4, 0
	bne cr7, 1f
	li 3, 1
1:
	blr


#        cmpi    7, 0, 3, 0
#        bne     7, 1f
#        addi    3, 3, 1
#1:      lmw     8, 4(3)               # load r8-r31
#        mr      6, 4
#        mtlr    11
#        mtcr    12
#        mr      2, 9
#        mr      1, 10
#        blr 
