#include "stdio_impl.h"

off_t __ftello_unlocked(FILE *f)
{
	off_t pos = f->seek(f, 0, SEEK_CUR);
	if (pos < 0) return pos;

	/* Adjust for data in buffer. */
	return pos - (f->rend - f->rpos) + (f->wpos - f->wbase);
}

off_t __ftello(FILE *f)
{
	off_t pos;
	FLOCK(f);
	pos = __ftello_unlocked(f);
	FUNLOCK(f);
	return pos;
}

long ftell(FILE *f)
{
	off_t pos = __ftello(f);
	if (pos > LONG_MAX) {
		errno = EOVERFLOW;
		return -1;
	}
	return pos;
}

weak_alias(__ftello, ftello);

LFS64(ftello);
