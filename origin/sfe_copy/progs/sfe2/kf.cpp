#include "kf.h"
////////////////////////////////////////////
// Creattion of a Kalman filter structure
//
// kf: KalmanFilter structure
// n:  dimension of the state
// m:  dimension of the input
////////////////////////////////////////////
void KFCreate(KalmanFilter *kf, int n, int m)
{
  kf->A  = gsl_matrix_calloc(n,n); 
  kf->B  = gsl_matrix_calloc(n,m); 
  kf->C  = gsl_matrix_calloc(n,m);

  kf->xc = gsl_matrix_calloc(n,1);
  kf->xp = gsl_matrix_calloc(n,1);
  kf->P  = gsl_matrix_calloc(n,n);
  kf->G  = gsl_matrix_calloc(n,1);
  kf->Q  = gsl_matrix_calloc(m,m);
  kf->R  = gsl_matrix_calloc(m,m);
  kf->I  = gsl_matrix_calloc(n,n);

  kf->tmp1 =gsl_matrix_calloc(n,m);
  kf->tmp2 =gsl_matrix_calloc(m,m);
  kf->tmp3 =gsl_matrix_calloc(m,n);
  kf->tmp4 =gsl_matrix_calloc(n,n);
  kf->tmp5 =gsl_matrix_calloc(m,1);
  kf->tmp6=0;
}

////////////////////////////////////////////
// Release of a Kalman filter structure
//
// kf: KalmanFilter structure
////////////////////////////////////////////
void KFFree(KalmanFilter *kf)
{
  gsl_matrix_free(kf->A); 
  gsl_matrix_free(kf->B); 
  gsl_matrix_free(kf->C); 
  gsl_matrix_free(kf->xc); 
  gsl_matrix_free(kf->xp); 
  gsl_matrix_free(kf->P); 
  gsl_matrix_free(kf->G); 
  gsl_matrix_free(kf->Q); 
  gsl_matrix_free(kf->R); 
  gsl_matrix_free(kf->I); 
  gsl_matrix_free(kf->tmp1); 
  gsl_matrix_free(kf->tmp2); 
  gsl_matrix_free(kf->tmp3); 
  gsl_matrix_free(kf->tmp4); 
  gsl_matrix_free(kf->tmp5); 
}

////////////////////////////////////////////
// Initilization of a Kalman filter structure
//
//   kf: KalmanFilter structure
// sigv: variance of the system noise
// sigw: variance of the measurement noise
//
// Settings must be changed according to the dimentions of N and M
///////////////////////////////////////////
void KFInit(KalmanFilter *kf, double sigv, double sigw)
{
  kf->dn=N;
  kf->dm=M;

  SetSystemMatrix(kf,a00,a01,a10,a11);

  gsl_matrix_set(kf->B,0,0,b00);
  gsl_matrix_set(kf->B,1,0,b10);

  gsl_matrix_set(kf->C,0,0,c00);
  gsl_matrix_set(kf->C,1,0,c10);

  gsl_matrix_set(kf->Q,0,0,sigv);
  gsl_matrix_set(kf->R,0,0,sigw);

  gsl_matrix_set_identity(kf->I);
  gsl_matrix_set_identity(kf->P);
}

////////////////////////////////////////////
// Kalman filter 
//
//   kf: KalmanFilter structure
//    y: measurment of the system
///////////////////////////////////////////
void KF(KalmanFilter *kf, gsl_matrix *y)
{
  //Prediction
  gsl_blas_dgemm(CblasNoTrans,CblasNoTrans,1,kf->A,kf->xc,0,kf->xp);     //xp=A*xc
  gsl_blas_dgemm(CblasNoTrans,CblasTrans,  1,kf->P,kf->A,0,kf->P);       //P=P*A^T
  gsl_blas_dgemm(CblasNoTrans,CblasNoTrans,1,kf->A,kf->P,0,kf->P);       //P=A*P
  gsl_blas_dgemm(CblasNoTrans,CblasTrans,  1,kf->Q,kf->B,0,kf->tmp3);    //tmp3=Q*B^T
  gsl_blas_dgemm(CblasNoTrans,CblasNoTrans,1,kf->B,kf->tmp3,0,kf->tmp4); //tmp4=B*tmp3
  gsl_matrix_add(kf->P,kf->tmp4);                                        //P=P+tmp4

  //Filtering
  ////Kalman gain
  gsl_blas_dgemm(CblasNoTrans,CblasNoTrans,1,kf->P,kf->C,0,kf->tmp1);   //tmp1=P*C
  gsl_blas_dgemm(CblasTrans,  CblasNoTrans,1,kf->C,kf->tmp1,0,kf->tmp2);//tmp2=C^T*tmp1
  gsl_matrix_add(kf->tmp2,kf->R);                                       //tmp2=tmp2+R 
  gsl_blas_dgemm(CblasNoTrans,CblasNoTrans,1,kf->P,kf->C,0,kf->G);      //G=P*C

  //***if M=1****
  if(kf->dm==1){
    kf->tmp6=gsl_matrix_get(kf->tmp2,0,0);                              //tmp6=tmp2(0,0)
    gsl_matrix_scale(kf->G,1/(double)kf->tmp6);                         //G=G*(1/tmp6)
  }
  //****elseif M>2****
  else{
    gsl_linalg_LU_decomp(kf->tmp2, p, &s);
    gsl_linalg_LU_invert(kf->tmp2, p, inv);
    gsl_blas_dgemm(CblasNoTrans,CblasNoTrans,1,kf->G,inv,0,kf->G);      //G=G*inv
  }

  ////state estimation
  gsl_blas_dgemm(CblasTrans,CblasNoTrans,1,kf->C,kf->xp,0,kf->tmp5);    //tmp5=C^T*xp
  gsl_matrix_sub(kf->tmp5,y);                                           //tmp5=tmp5-y
  gsl_matrix_scale(kf->tmp5,-1.0);                                      //tmp5=-1*tmp5 
  gsl_blas_dgemm(CblasNoTrans,CblasNoTrans,1,kf->G,kf->tmp5,0,kf->xc);  //xc=G*tmp5
  gsl_matrix_add(kf->xc,kf->xp);                                        //xc=xp+xc 

  ////P 
  gsl_blas_dgemm(CblasNoTrans,CblasTrans,1,kf->G,kf->C,0,kf->tmp4);     //tmp4=G*C^T
  gsl_matrix_sub(kf->tmp4,kf->I);                                       //tmp4=tmp4-I
  gsl_matrix_scale(kf->tmp4,-1.0);                                      //tmp4=-1*tmp4 
  gsl_blas_dgemm(CblasNoTrans,CblasNoTrans,1,kf->tmp4,kf->P,0,kf->P);   //P=tmp4*P
}

////////////////////////////////////////////
// state evolution
//
//   kf: KalmanFilter structure
//    x: the state of system
//    v: system noise
//    w: measurment noise
///////////////////////////////////////////
double StateEvol(KalmanFilter *kf, gsl_matrix *x, double v,double w) 
{
  gsl_blas_dgemm(CblasNoTrans,CblasNoTrans,1,kf->A,x,0,x);  //x=A*x
  gsl_matrix_memcpy(kf->tmp1,kf->B); //tmp1=B
  gsl_matrix_scale(kf->tmp1,v);      //tmp1=tmp1*v
  gsl_matrix_add(x,kf->tmp1);        //x=x+tmp1
  gsl_blas_dgemm(CblasTrans,CblasNoTrans,1,kf->C,x,0,kf->tmp2);   //tmp2=C*x

  return gsl_matrix_get(kf->tmp2,0,0)+w;    //y=tmp2+w
}

////////////////////////////////////////////
// stet system matrix A
//
//   kf: KalmanFilter structure
///////////////////////////////////////////
void SetSystemMatrix(KalmanFilter *kf, 
		     double a00, double a01, 
		     double a10, double a11) 
{
  gsl_matrix_set(kf->A,0,0,a00);
  gsl_matrix_set(kf->A,0,1,a01);
  gsl_matrix_set(kf->A,1,0,a10);
  gsl_matrix_set(kf->A,1,1,a11);
}
