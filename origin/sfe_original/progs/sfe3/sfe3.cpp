/// 2013 12/5
/// Takeshi Nishida
/// カルマンフィルタを導入

#include "sfe.h"
#include "kf2.h"

///////////////////////////////////////////////////
// main
///////////////////////////////////////////////////
#define TOTAL 1000
int main(int argc, char** argv)
{

#define NUM 50
#define Ts 0.01

  int cnt=0,k=0,i,j;
  CvRNG rng = cvRNG(-1);
  char code = -1;
  FILE *gp1,*gp2,*fp,*fp2;
  double *x,*p,*q,*d,*plot,*ewp;
  double z,tw,kew,kz;
  static double ew=0;
  double mu=NUM/(double)2;
  double sum1=0,sum2=0,sum3=0,sum4=0;
  static double sig=((NUM-20)/2+20)*Ts/(double)16;
  double sig2,sig4,r;
  double check;

  gsl_rng_env_setup();  
  gsl_rng_type *T=(gsl_rng_type *)gsl_rng_default;
  gsl_rng *GSLrng=gsl_rng_alloc(T);
  gsl_rng_set(GSLrng,time (NULL));

#ifdef KF
  KFCreate(&kf,N,M);     //create a Kalman filter
  KFInit(&kf,sigv,sigw); //initialization of the Kalman filter
#endif

  sig2=sig*sig;
  sig4=sig2*sig2;
  printf("sigma=%lf  mu=%lf\n",sig,mu);

  fp=fopen("err.dat","w");
  if(fp==NULL){
    fprintf(stderr,"Do not open error.dat");
    exit(EXIT_FAILURE);
  }
  fp2=fopen("check.dat","w");
  if(fp==NULL){
    fprintf(stderr,"Do not open error.dat");
    exit(EXIT_FAILURE);
  }

  //#define GNUPLOT
#ifdef GNUPLOT
  gp1=popen("gnuplot -persist -geometry 500x300+510+380","w");
  if(gp1==NULL){
    fprintf(stderr, "Do Not Opne GNUPLOT");
    exit(EXIT_FAILURE);
  }
  fprintf(gp1,"set terminal x11 \n");
  fprintf(gp1,"set xrange [0:1000] \n");
  //fprintf(gp1,"set yrange [-1.1:1.1] \n");
  fprintf(gp1,"set xlabel \"time\" \n");
  fprintf(gp1,"set ylabel \"estimation error\" \n");
  fflush(gp1);
#endif

  x   =(double*)calloc(sizeof(double),NUM);
  p   =(double*)calloc(sizeof(double),NUM);
  q   =(double*)calloc(sizeof(double),NUM);
  d   =(double*)calloc(sizeof(double),NUM);
  plot=(double*)calloc(sizeof(double),TOTAL);
  ewp =(double*)calloc(sizeof(double),TOTAL);

  for(i=0;i<NUM;i++){
    p[i]=exp(-1*pow((i-mu)*Ts,2)/(2*sig2));
    q[i]=(pow((i-mu)*Ts,2)-sig2)/sig4;
    d[i]=(i-mu)*Ts/sig2;
  }
  tw=2*CV_PI;  

  for(k=0;k<TOTAL;k++){
    z=sin(tw*k*Ts)+gsl_ran_gaussian(GSLrng,sigw); //measurement 
    plot[k]=z;

    if(k<NUM) x[k]=z;
    else {
      for(i=1;i<NUM;i++) x[i-1]=x[i]; 
      x[NUM-1]=z;    

      for(sum1=0,sum2=0,sum3=0,i=0;i<NUM;i++){
	sum1+=x[i]*p[i]*q[i];
	sum2+=x[i]*p[i];
	sum3+=x[i]*d[i];
      }
      check=-1*sum1/sum2;
      if(check>0 && fabs(sum2)>1e-2)  ew=sqrt(check);

      fprintf(fp2,"%d %lf %lf %lf %lf\n",k,sum1,sum2,sum3,check);

#ifdef KF
      gsl_matrix_set(y,0,0,ew);
      KF(&kf,y);
      kew=gsl_matrix_get(kf.xc,0,0);
      ewp[k]=tw-kew;
#endif

      //if(k>NUM) fprintf(fp,"%d %lf %lf %lf\n",k,plot[k],tw-ew,ewp[k]);
      if(k>NUM) fprintf(fp,"%d %lf %lf\n",k,plot[k],tw-ew);

#ifdef GNUPLOT
      if(k>NUM) fprintf(gp1, "plot '-' with steps linetype 1\n");
      for(i=0;i<k;i++) fprintf(gp1, "%f\n",ewp[i]); 
      fprintf(gp1, "e\n");
      fflush(gp1);
#endif
    }

    code = (char)cvWaitKey(10);
    if( code == 27 || code == 'q' || code == 'Q' )  break;
  }

  fclose(fp);

#ifdef KF
  KFFree(&kf);
#endif

#ifdef GNUPLOT
  fclose(gp1);
#endif

  return 0;
}
