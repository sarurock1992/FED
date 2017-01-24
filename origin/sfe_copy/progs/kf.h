#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>
#include <memory.h>
#include <sys/file.h>
#include <gsl/gsl_matrix.h>
#include <gsl/gsl_vector.h>
#include <gsl/gsl_linalg.h>
#include <gsl/gsl_blas.h>
#include <gsl/gsl_rng.h>
#include <gsl/gsl_randist.h>
#include <gsl/gsl_cdf.h>

//////////////////////////////////
// changable parameters
//////////////////////////////////
#define TOTAL 100

#define N 2 //dimention of state
#define M 1 //dimention of input

//A
double a00= 0.0;
double a01=-0.7;
double a10= 1.0;
double a11=-1.5;
//B
double b00=0.5;
double b10=1.0;
//C
double c00=0.0;
double c10=1.0;
//sigma
double sigv=1.0;
double sigw=0.1;
////////////////////////////////

typedef struct{
  int dn; //dimention of state
  int dm; //dimention of input

  gsl_matrix *A; 
  gsl_matrix *B; 
  gsl_matrix *C; 

  gsl_matrix *xc; //current  hat_x(k)
  gsl_matrix *xp; //previous hat_x-(k)
  gsl_matrix *P;
  gsl_matrix *G;
  gsl_matrix *Q;
  gsl_matrix *R;
  gsl_matrix *I;

  gsl_matrix *tmp1;
  gsl_matrix *tmp2;
  gsl_matrix *tmp3;
  gsl_matrix *tmp4;
  gsl_matrix *tmp5;
  double tmp6;
}KalmanFilter;

KalmanFilter kf;

gsl_matrix *x   =gsl_matrix_calloc(N,1); //true state value
gsl_matrix *y   =gsl_matrix_calloc(M,1); 

gsl_matrix *inv    = gsl_matrix_alloc(M,M);
gsl_permutation *p = gsl_permutation_alloc(N);
int s;

////// functions
void KFCreate(KalmanFilter *, int, int, int);
void KFFree(KalmanFilter *);
void KFInit(KalmanFilter *, double, double);
void KF(KalmanFilter *, gsl_matrix *);
double StateEvol(KalmanFilter *, gsl_matrix *, double, double ) ;
void SetSystemMatrix(KalmanFilter *, double, double,double, double) ;
