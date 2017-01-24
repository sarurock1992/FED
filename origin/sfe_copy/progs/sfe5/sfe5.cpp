
#include "sfe2.h"

// main
#define TOTAL 500

int main(int argc, char** argv)
{
  #define NUM 20

	#define Ts 0.001//1000
  //#define Ts 0.002//500
	//#define Ts 0.004//250
	//#define Ts 0.005//200
	//#define Ts 0.01//100
	//#define Ts 0.02//50
	//#define Ts 0.025//40
	//#define Ts 0.05//20
	//#define Ts 0.1//10

  int k=0,i,j;
 
  char code = -1;
  char buff[1500];//追加
  FILE *gp1,*fp,*fp2,*fd;//追加
  double *x,*p,*q,*d,*data,*plot,*pew;//追加
  double z;
  static double ew=0;
  double mu=NUM/(double)2;
  double sum1=0,sum2=0,sum3=0;
  static double sig=((NUM-20)/2+20)*Ts/(double)16;
  double sig2,sig4;
  double check;//sigma
	// double last_check;
	// double last_sum1 = 0;
	// double last_sum2 = 0;
  sig2=sig*sig;
  sig4=sig2*sig2;
  data=(double*)malloc(TOTAL*sizeof(double));

#define GNUPLOT
#ifdef GNUPLOT

  //推定結果記入ファイルの準備
  fp=fopen("dfe.dat","w");
  if(fp==NULL){
    fprintf(stderr,"Do not open error.dat");
    exit(EXIT_FAILURE);
  }

  gp1=popen("gnuplot -persist -geometry 1000x300+300+580","w");
  if(gp1==NULL){
    fprintf(stderr, "Do Not Opne GNUPLOT");
    exit(EXIT_FAILURE);
  }
  fprintf(gp1,"set terminal x11 \n");
  fprintf(gp1,"set xrange [0:TOTAL] \n");
	//fprintf(gp1,"set yrange [1.54:1.58] \n");
  fprintf(gp1,"set xlabel \"time\" \n");
  fprintf(gp1,"set ylabel \"estimated frequency\" \n");
  fflush(gp1);

#endif


  //推定結果を解析するためのデータ記入ファイルの準備
  fp2=fopen("check.dat","w");
  if(fp==NULL){
    fprintf(stderr,"Do not open error.dat");
    exit(EXIT_FAILURE);
  }

  x   =(double*)calloc(sizeof(double),NUM);//計測データ
  p   =(double*)calloc(sizeof(double),NUM);///////
  q   =(double*)calloc(sizeof(double),NUM);//準備できる数値配列
  d   =(double*)calloc(sizeof(double),NUM);///////
  plot=(double*)calloc(sizeof(double),TOTAL);//データプロット用配列
  pew =(double*)calloc(sizeof(double),TOTAL);//データプロット用配列
 
	//準備
  for(i=0; i<NUM; i++){
    p[i]=exp(-1*pow((i-mu)*Ts,2)/(2*sig2));
    q[i]=(pow((i-mu)*Ts,2)-sig2)/sig4;
    d[i]=(i-mu)*Ts/sig2;
  }

  //// read data file /////////////
	//fd=fopen("./accdata/1000.csv","r");//振り子角速度1000Hz
	//fd=fopen("./accdata/500.csv","r");//振り子角速度500Hz
	//fd=fopen("./accdata/250.csv","r");//振り子角速度250Hz
	//fd=fopen("./accdata/200.csv","r");//振り子角速度200Hz
	//fd=fopen("./accdata/100.csv","r");//振り子角速度100Hz
	//fd=fopen("./accdata/50.csv","r");//振り子角速度50Hz
	//fd=fopen("./accdata/40.csv","r");//振り子角速度40Hz
	//fd=fopen("./accdata/20.csv","r");//振り子角速度20Hz
	//fd=fopen("./accdata/10.csv","r");//振り子角速度10Hz
  //fd=fopen("./accdata/1000hzmin.csv","r");
	//fd=fopen("./accdata/100_mini.csv","r");
  
	fd=fopen("./accdata/coswave.csv","r");//cos波1000Hz,omega=6.75
  //fd=fopen("./accdata/err1.dat","r");//sin波100Hz

  if(fd==NULL){
    fprintf(stderr,"Do not open data file");
    exit(EXIT_FAILURE);
  }

  for(i=0; i<=TOTAL; i++){
    fgets(buff,1500,fd);
    sscanf(buff,"%d,%lf",&j,&data[i]);
    printf("%d %lf\n",i,data[i]);
  }
  fclose(fd);

  for(k=0; k<=TOTAL; k++){
    plot[k]=z=data[k];

    if(k<NUM) x[k]=z;
    else {

      for(i=1; i<NUM; i++) x[i-1]=x[i];//シフトさせデータをx[i]に入れる
      x[NUM-1]=z;  
 
      for(sum1=0,sum2=0,sum3=0,i=0; i<NUM; i++){
         	sum1+=x[i]*p[i]*q[i];
        	sum2+=x[i]*p[i];
	        sum3+=x[i]*d[i]; 
      }

      check = -1 * sum1/sum2; //推定周波数の二乗
			
			if ( check>0 ) // && fabs(sum2) > 1e-6 )
				//&& last_sum1*sum1 >0 && last_sum2*sum2 >0 && fabs(last_check)/sqrt(2)<fabs(check) && fabs(check)<sqrt(2)*fabs(last_check) ){
   	  ew=sqrt(check);
			// 	// }
			// 	// last_sum1 = sum1;			
			// 	// last_sum2 = sum2;
			// 	// last_check = check;
			fprintf(fp2,"%d,%lf\n",k,ew);
      //fprintf(fp2,"%d,%lf,%lf,%lf,%lf,%lf,%lf\n",k,data[k],sum1,sum2,sum3,check,ew);
    }

		#ifdef GNUPLOT
    fprintf(fp,"%d,%lf\n",k,ew);
    pew[k]=ew;
    if(k>NUM) fprintf(gp1, "plot '-' with steps linetype 1\n");
    for(i=0;i<k;i++) fprintf(gp1, "%f \n",pew[i]); 
    fprintf(gp1, "e\n");
    fflush(gp1);
#endif
    code = (char)cvWaitKey(10);
    if( code == 27 || code == 'q' || code == 'Q' )  break;
  }
	pclose(gp1);
  fclose(fp);
  fclose(fp2);
  return 0;
}
