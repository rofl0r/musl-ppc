        .global sigsetjmp
        .type sigsetjmp,@function
sigsetjmp:
        lwz     4, 64*4-2*4(3)        # Second last long.
        cmpi    4, 0, 4, 0
        bne     4, 1f
        addi    5, 3, 64*4-1*4        # Address of last long.
        li      4, 0
        li      3, 2
        bl      sigprocmask
1:      b       setjmp
