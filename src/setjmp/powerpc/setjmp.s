        .global __setjmp
        .global _setjmp
        .global setjmp
        .type   __setjmp,@function
        .type   _setjmp,@function
        .type   setjmp,@function
__setjmp:
_setjmp:
setjmp:
        mflr    11
        mfcr    12
        mr      10, 1
        mr      9, 2
        stmw    8, 0(3)               # save r8-r31
        li      3,0
        blr

