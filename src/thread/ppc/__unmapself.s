        .text
        .global __unmapself
        .type   __unmapself,%function
__unmapself:
        li      r0, 91 // __NR_munmap
        sc
        li      r0, 1 //__NR_exit
        sc
        blr
