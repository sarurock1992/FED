#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct complex {
  double r;
  double i;
};

int bitr( int bit, int r );

void swap( struct complex *d0, complex *d1 );

double fft(int N, double *data, double Ts);
