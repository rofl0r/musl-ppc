        .global _longjmp
        .global longjmp
        .type   _longjmp,@function
        .type   longjmp,@function
_longjmp:
longjmp:
        cmpi    7, 0, 3, 0
        bne     7, 1f
        addi    3, 3, 1
1:      lmw     8, 4(3)               # load r8-r31
        mr      6, 4
        mtlr    11
        mtcr    12
        mr      2, 9
        mr      1, 10
        blr 
