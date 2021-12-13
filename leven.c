#include <stdio.h>
 
int levenshtein_c(char *x, char *y, int lx, int ly)
{
	int tbl[lx + 1][ly + 1];
 
	for (int i = 0; i <= lx; i++) {
		for (int j = 0; j <= ly; j++)
			tbl[i][j] = -1;
	}
 
	int distance(int i, int j) {
		if (tbl[i][j] >= 0) 
			return tbl[i][j];
 
		int a;
		if (i == lx)
			a = ly - j;
		else if (j == ly)
			a = lx - i;
		else if (x[i] == y[j])
			a = distance(i + 1, j + 1);
		else {
			a = distance(i + 1, j + 1);
 
			int b;
			if ((b = distance(i, j + 1)) < a) 
				a = b;
			if ((b = distance(i + 1, j)) < a) 
				a = b;
			++a;
		}
		return tbl[i][j] = a;
	}
	return distance(0, 0);
}
