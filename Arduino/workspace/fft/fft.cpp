#include "fft.h"

int bitr( int bit, int r ) {
  int i, bitr;

  bitr = 0;
  for (i = 0; i < r; i++) {
    bitr <<= 1;
    bitr |= (bit & 1);
    bit  >>= 1;
  }
  return ( bitr );
}

void swap( struct complex *d0, complex *d1 ) {

  double a;

  a     = d0->r;
  d0->r = d1->r;
  d1->r = a;
  a     = d0->i;
  d0->i = d1->i;
  d1->i = a;

}

double fft(int N, double *data, double Ts) {

  int n, k, r, i, j, j1, j2, p, k1, bit, k_max;
  double a, b, amp_max, v_window;
  complex *x;
  double amp[N];

  x = (complex *)calloc(sizeof(complex), N * N);

  for (k = 0; k < N; k++) {

    v_window = 0.54 - 0.46 * cos(2 * M_PI * k / (N - 1));

    x[k].r = data[k] * v_window;
    x[k].i = 0.0;
  }

  r = 0;
  i = N >> 1;

  while (i > 0) {
    i >>= 1;
    r++;
  }

  n = 1 << r;
  j2 = n;
  k = 0;
  j1 = r - 1;

  for (j = 0; j < r; j++) {

    j2 >>= 1;

    for (;;) {

      for (i = 0; i < j2; i++) {

        p = k >> j1;
        k1 = k + j2;

        a = x[k1].r * cos(2.0 * M_PI / n * bitr(p, r))
            + x[k1].i * sin(2.0 * M_PI / n * bitr(p, r));
        b = x[k1].i * cos(2.0 * M_PI / n * bitr(p, r))
            - x[k1].r * sin(2.0 * M_PI / n * bitr(p, r));

        x[k1].r = x[k].r - a;
        x[k1].i = x[k].i - b;
        x[k].r = x[k].r + a;
        x[k].i = x[k].i + b;
        k++;

      }

      k += j2;
      if (k >= n) break;
    }
    k = 0;
    j1--;
  }

  for (k = 1; k <= n; k++) {
    bit = bitr(k, r);
    if (bit > k) swap(&x[k], &x[bit]);
  }

  k_max = amp_max = 0;

  for (k = 1; k <= N; k++) {

    amp[k] = sqrt(pow(x[k].r, 2) + pow(x[k].i, 2));

    if (k != 0 && amp_max < amp[k]) {
      k_max = k;
      amp_max = amp[k];
    }
  }
  return k_max / (Ts * N);
  free(x);
}
