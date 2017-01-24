/// 2013 12/5
/// Takeshi Nishida
/// 

#include "sfe.h"

///////////////////////////////////////////////////
// main
///////////////////////////////////////////////////
#define TOTAL 1000
int main(int argc, char** argv)
{

#define N 20
#define Ts 0.01

  int cnt=0,k=0,i,j;
  CvRNG rng = cvRNG(-1);
  char code = -1;
  FILE *gp1,*gp2,*fp;
  double *x,*p,*plot,*ewp;
  double z,tw,ew;
  double mu=N/(double)2;
  double sum1=0,sum2=0;
  static double sig=((N-20)/2+20)*Ts/(double)16;
  double sig2,sig4,r;
  double check;

  sig2=sig*sig;
  printf("sigma=%lf  mu=%lf\n",sig,mu);

#define GNUPLOT
#ifdef GNUPLOT
  fp=fopen("err.dat","w");
  if(fp==NULL){
    fprintf(stderr,"Do not open error.dat");
    exit(EXIT_FAILURE);
  }

  gp1=popen("gnuplot -persist -geometry 500x300+510+380","w");
  if(gp1==NULL){
    fprintf(stderr, "Do Not Opne GNUPLOT");
    exit(EXIT_FAILURE);
  }
  fprintf(gp1,"set terminal x11 \n");
  fprintf(gp1,"set xrange [0:1000] \n");
  fprintf(gp1,"set yrange [-1.1:1.1] \n");
  fprintf(gp1,"set xlabel \"time\" \n");
  fprintf(gp1,"set ylabel \"estimation error\" \n");
  fflush(gp1);
#endif
  x   =(double*)calloc(sizeof(double),N);
  p   =(double*)calloc(sizeof(double),N);
  plot=(double*)calloc(sizeof(double),TOTAL);
  ewp =(double*)calloc(sizeof(double),TOTAL);

  for(i=0;i<N;i++)
    p[i]=exp(-pow((i-mu)*Ts,2)/(2*sig2))/sqrt(2*CV_PI*sig2);

  tw=0.25*2*CV_PI;  
  for(k=0;k<TOTAL;k++){
    r=0.5*(cvRandReal(&rng)-0.5);// r\in rand[-1,1]
    z=sin(tw*k*Ts)+0.1*r; //measurement 
    
    if(k<N) x[k]=z;
    else {for(i=1;i<N;i++) x[i-1]=x[i]; x[N-1]=z;}
    
    for(sum1=0,sum2=0,i=0;i<N;i++){
      sum1+=x[i]*p[i]*pow((i-mu)*Ts,2);
      sum2+=x[i]*p[i];
    }
    check=sig2-sum1/sum2;
    if(check>0 && sum2>1e-6) ew=sqrt(check)/sig2;

    //if(k>N) printf("%d %lf %lf %lf %lf %lf %lf \n",k,ew, tw-ew, sig2, sum1, sum2, sum1/sum2);

#ifdef GNUPLOT
    plot[k]=z;
    ewp[k]=tw-ew;
    fprintf(fp,"%d %lf %lf\n",k,plot[k],ewp[k]);
    if(k>N) fprintf(gp1, "plot '-' with steps linetype 1\n");
    for(i=0;i<k;i++) fprintf(gp1, "%f\n",plot[i]); 
    fprintf(gp1, "e\n");
    fflush(gp1);
#endif

    code = (char)cvWaitKey(10);
    if( code == 27 || code == 'q' || code == 'Q' )  break;
  }
  
  return 0;
}
