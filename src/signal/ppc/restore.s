        .global __restore
        .type __restore,@function
__restore:
        li      r0, 119 //__NR_sigreturn
        sc

        .global __restore_rt
        .type __restore_rt,@function
__restore_rt:
        li      r0, 172 // __NR_rt_sigreturn
        sc
