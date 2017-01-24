#include <stdio.h>
#include <math.h>
#include <iostream>
#include <malloc.h>

using namespace std;

typedef struct{
	double r;
	double i;
}complex;

int bitr( int bit, int r ){
	int i,bitr;

	bitr = 0;
	for (i=0; i<r; i++){
		bitr <<= 1;
		bitr |= (bit & 1);
		bit  >>= 1;
	}
	return( bitr );
}

void swap( complex *d0, complex *d1 ){

	double a;

	a     = d0->r;
	d0->r = d1->r;
	d1->r = a;
	a     = d0->i;
	d0->i = d1->i;
	d1->i = a;
}

int main(void){	
	int n, k, N, r, i, j, j1, j2, p, k1, bit;
	double a, b;
	complex *x;

	cout << "Nの値を入力してください．" << endl;
	scanf("%d",&N);
	cout << "N = " << N << endl;

	x = (complex *)malloc(sizeof(complex) * N*N );

	cout << "データを入力してください" << endl;
	for (k=0; k<N; k++){
		scanf("%lf", &x[k].r);
		x[k].i = 0.0;
	}

	r = 0;
	i = N>>1;

	while(i>0){
		i >>=1;
		r++;
	}

	n = 1<<r;
	j2 = n;
	k = 0;
	j1 = r-1;
	
	for (j=0; j<r; j++){

		j2>>=1;

		for (;;){
			
			for (i=0; i<j2; i++){

				p = k>>j1;
				k1 = k + j2;

				a = x[k1].r*cos(2.0*M_PI/n*bitr(p,r))
				   +x[k1].i*sin(2.0*M_PI/n*bitr(p,r));
				b = x[k1].i*cos(2.0*M_PI/n*bitr(p,r))
				   -x[k1].r*sin(2.0*M_PI/n*bitr(p,r));

				x[k1].r = x[k].r-a;
				x[k1].i = x[k].i-b;
				x[k].r = x[k].r+a;
				x[k].i = x[k].i+b;
				k++;
				
			}
			
			k += j2;
			if (k>=n) break;   
		}
		k = 0;
		j1--;
	}

	for (k=0; k<n; k++){
		bit = bitr(k,r);
		if (bit > k) swap(&x[k],&x[bit]);
	}

	for (k=0; k<N; k++){
		cout << "x[" << k << "].r=" << x[k].r << " x[" << k << "].i=" << x[k].i << endl; 
	}
	free(x);
}
