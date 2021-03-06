#if defined(_POSIX_SOURCE) || defined(_POSIX_C_SOURCE) \
 || defined(_XOPEN_SOURCE) || defined(_GNU_SOURCE) || defined(_BSD_SOURCE)

typedef struct {
	unsigned __mc1[2];
	unsigned long long __mc2[65];
	unsigned __mc3[5];
	unsigned long long __mc4[2];
	unsigned __mc5[6];
} mcontext_t;

typedef struct __ucontext {
	unsigned long uc_flags;
	struct __ucontext *uc_link;
	stack_t uc_stack;
	mcontext_t uc_mcontext;
	sigset_t uc_sigmask;
	unsigned long uc_regspace[128];
} ucontext_t;

#define SA_NOCLDSTOP  1
#define SA_NOCLDWAIT  0x10000
#define SA_SIGINFO    8
#define SA_ONSTACK    0x08000000
#define SA_RESTART    0x10000000
#define SA_NODEFER    0x40000000
#define SA_RESETHAND  0x80000000
#define SA_RESTORER   0x04000000

#undef SIG_BLOCK
#undef SIG_UNBLOCK
#undef SIG_SETMASK
#define SIG_BLOCK     1
#define SIG_UNBLOCK   2
#define SIG_SETMASK   3

#if defined(_GNU_SOURCE) || defined(_BSD_SOURCE)
struct sigcontext
{
	unsigned sc_regmask, sc_status;
	unsigned long long sc_pc, sc_regs[32], sc_fpregs[32];
	unsigned sc_ownedfp, sc_fpc_csr, sc_fpc_eir, sc_used_math, sc_dsp;
	unsigned long long sc_mdhi, sc_mdlo;
	unsigned long sc_hi1, sc_lo1, sc_hi2, sc_lo2, sc_hi3, sc_lo3;
};
#define NSIG      64
#endif

#endif

#define SIGHUP    1
#define SIGINT    2
#define SIGQUIT   3
#define SIGILL    4
#define SIGTRAP   5
#define SIGABRT   6
#define SIGIOT    SIGABRT
#define SIGSTKFLT 7
#define SIGFPE    8
#define SIGKILL   9
#define SIGBUS    10
#define SIGSEGV   11
#define SIGSYS    12
#define SIGPIPE   13
#define SIGALRM   14
#define SIGTERM   15
#define SIGUSR1   16
#define SIGUSR2   17
#define SIGCHLD   18
#define SIGPWR    19
#define SIGWINCH  20
#define SIGURG    21
#define SIGIO     22
#define SIGPOLL   SIGIO
#define SIGSTOP   23
#define SIGTSTP   24
#define SIGCONT   25
#define SIGTTIN   26
#define SIGTTOU   27
#define SIGVTALRM 28
#define SIGPROF   29
#define SIGXCPU   30
#define SIGXFSZ   31
#define SIGUNUSED SIGSYS
