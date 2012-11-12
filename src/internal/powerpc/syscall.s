	.global __syscall
	.type   __syscall,@function
__syscall:
#	mflr    0
#	stw     0, -4(1)              # Save the return address.
	mr      0, 3                  # Save the system call number
	mr      3, 4                  # Shift the arguments: arg1
	mr      4, 5                  # arg2
	mr      5, 6                  # arg3
	mr      6, 7                  # arg4
	mr      7, 8                  # arg5
	mr      8, 9                  # arg6
	sc
	bnslr+ # return if not summary overflow
	#else error:
	# return negated value.
	neg 3, 3
	blr
#	mfcr    0                      # Check for an error
#	rlwinm  4, 0, 0, 3, 3        # by checking for bit 28.
#	cmplwi  0, 4, 0               # It is an error if non-zero.
#	beq     0, 1f                  # Jump if not an error.
#	neg     3, 3                  # Negate the error number.
#1:      lwz     0, -4(1)              # Restore the return address.
#	mtlr    0
	blr
	.end    __syscall
	.size   __syscall, .-__syscall
