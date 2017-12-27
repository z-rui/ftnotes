#include <math.h>
#include <complex.h>
#include <stdio.h>

#define N 64

double complex x[N];
double complex X[N];

int main()
{
	int n, k;
	for (n = 0; n < N; n++) {
		double t = 2*M_PI*n/N;
		x[n] = cos(t) - cos(3*t) / 3 + cos(5*t) / 5;
	}
	for (n = 0; n < N; n++)
		printf("%f\n", creal(x[n]));
	putchar('\n');
	for (k = 0; k < N; k++) {
		X[k] = 0;
		for (n = 0; n < N; n++) {
			X[k] += x[n] * cexp(-I * 2*M_PI*k/N * n);
		}
	}
	for (k = 0; k < N; k++) {
		printf("%f\n", creal(X[k]));
	}
	return 0;
}
