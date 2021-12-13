from functools import wraps

cdef extern from "leven.h":
	int levenshtein_c(char *x, char *y, int lx, int ly);
	
def memoize(levenshtein):
	queried = {}
	@wraps(levenshtein)
	def memorize(x, y):
		x = x.lower()
		y = y.lower()
		xy = tuple(sorted((x, y)))
		if xy in queried:
			ldist = queried[xy]
		else:
			ldist = levenshtein(x, y)
			queried[xy] = ldist
		return ldist
	return memorize

@memoize
def levenshtein(x, y):
	cdef int lx = len(x)
	cdef int ly = len(y)
	cdef bytes x_bytes = x.encode()
	cdef char* c_x = x_bytes
	cdef bytes y_bytes = y.encode()
	cdef char* c_y = y_bytes
	return levenshtein_c(c_x, c_y, lx, ly)
	
def lev_ratio(x, y):
	lx = len(x)
	ly = len(y)
	lensum = max(lx, ly)
	ldist = levenshtein(x, y)
	ratio = (lensum - ldist) / lensum
	return ratio
	
