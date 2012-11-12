.text
.global __clone
.type __clone, %function
__clone:
# int clone(fn, stack, flags, arg, ptid, tls, ctid)
#            a  b       c     d     e    f    g
#            3  4       5     6     7    8    9
# tid = syscall(SYS_clone,c,b,e,f,g);
# if (!tid) syscall(SYS_exit, a(d));
# return tid;
# SYS_clone = 120
# SYS_exit = 1

# save "a" into r10
mr 10, 3
# save "d" into r11
mr 11, 6

#move c into first arg
mr 3, 5
#mr 4, 4
mr 5, 7
mr 6, 8
mr 7, 9

# move syscall number into r0    
li 0, 120

sc

# check for error
mfcr    0                      # Check for an error
rlwinm  4, 0, 0, 3, 3        # by checking for bit 28.
cmplwi  0, 4, 0               # It is an error if non-zero.
beq     0, 1f                  # Jump if not an error.
neg     3, 3                  # Negate the error number.
blr

1:
# compare sc result with 0
cmpwi cr7, 3, 0

# if not 0, jump to end
bne cr7, 2f

#else
#call funcptr
# move arg (d) into r3
mr 3, 11
#move r10 (funcptr) into CTR reg
mtctr 10
# call CTR reg
bctrl
# mov SYS_exit into r0 (the exit param is already in r3)
li 0, 1
sc

2:
blr




