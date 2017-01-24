/// 2013 12/5
/// Takeshi Nishida
/// 綺麗なターゲットを追跡できる

#include "sfe.h"

///////////////////////////////////////////////////
// main
///////////////////////////////////////////////////
#define TOTAL 3000
int main(int argc, char** argv)
{

#define N 21

#define Ts 0.01

  int cnt=0,k=0,i,j;
  CvRNG rng = cvRNG(-1);
  char code = -1;
  FILE *gp1,*gp2,*fp;
  double *x,*p,*plot;
  double z,tw,ew;
  double mu=N/(double)2;
  double sum1=0,sum2=0;
  //static double sig=((N-20)/2+20)*Ts/(double)16;
  static double sig=(21)*Ts/(double)16;
  double sig2;
  double r, check;

  sig2=sig*sig;
  del2=del*del;

  printf("sigma=%lf mu1=%lf delta=%lf mu2=%lf\n",sig,mu1,del,mu2);

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
  fprintf(gp1,"set xrange [0:3000] \n");
  fprintf(gp1,"set yrange [-1.1:1.1] \n");
  fprintf(gp1,"set xlabel \"time\" \n");
  fprintf(gp1,"set ylabel \"estimation error\" \n");
  fflush(gp1);
#endif
  x1  =(double*)calloc(sizeof(double),N1);
  p1  =(double*)calloc(sizeof(double),N1);
  x2  =(double*)calloc(sizeof(double),N2);
  p2  =(double*)calloc(sizeof(double),N2);
  plot=(double*)calloc(sizeof(double),TOTAL);

  for(i=0;i<N1;i++)
    p1[i]=exp(-pow((i-mu1)*Ts,2)/(2*sig2))/sqrt(2*CV_PI*sig2);

  for(i=0;i<N2;i++)
    p2[i]=exp(-pow((i-mu2)*Ts,2)/(2*del2))/sqrt(2*CV_PI*del2);

  tw=0.25*2*CV_PI;  

  for(k=0;k<TOTAL;k++){
    r=0.5*(cvRandReal(&rng)-0.5); // r\in rand[-1,1]
    z=sin(tw*k*Ts)+0.1*r; //measurement 
    
    if(k<N1) x1[k]=z;
    else {for(i=1;i<N1;i++) x1[i-1]=x1[i]; x1[N1-1]=z;}

    if(k<N2) x2[k]=z;
    else {for(i=1;i<N2;i++) x2[i-1]=x2[i]; x2[N2-1]=z;}
    
    for(sum1=0,sum2=0,i=0;i<N1;i++){
      sum1+=x1[i]*p1[i]*pow((i-mu1)*Ts,2);
      sum2+=x1[i]*p1[i];
    }
    ew1=sqrt((sig2-sum1/sum2))/sig2;

    for(sum1=0,sum2=0,i=0;i<N2;i++){
      sum1+=x2[i]*p2[i]*pow((i-mu2)*Ts,2);
      sum2+=x2[i]*p2[i];
    }
    ew2=sqrt((del2-sum1/sum2))/del2;

    ew=(ew1+ew2)/2;    
    printf("%d %lf %lf\n",k,ew, fabs(tw-ew));

#ifdef GNUPLOT
    plot[k]=z;
    fprintf(fp,"%d %lf %lf %lf\n",k,plot[k],tw-ew2,tw-ew);
    fprintf(gp1, "plot '-' with lines linetype 1\n");
    for(i=0;i<k;i++) fprintf(gp1, "%f\n",plot[i]); 
    fprintf(gp1, "e\n");
    fflush(gp1);
#endif

    code = (char)cvWaitKey(10);
    if( code == 27 || code == 'q' || code == 'Q' )  break;
  }
  
  return 0;
}
