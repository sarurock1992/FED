#include "dfe.h"
#include "random"
#include "iostream"

int main(void){

//#define TOTAL 1200

	int i,TOTAL;
	//char filename[20];
	double x,mu,sigma,Ts,s;
	FILE *fp;

	Ts = 0.001;
	TOTAL = 301;
	mu = TOTAL*Ts/2;
	sigma = 0.02;
	
		fp = fopen("gauss.dat","w");
		if(fp==NULL){
			fprintf(stderr,"Do not open error.dat");
			exit(EXIT_FAILURE);
		}
		
	   	for(i=0; i*Ts<=(TOTAL+1)*Ts; i++){
			s = Ts*i;
			x = (1/sqrt(2*M_PI*sigma))*exp(-pow((s-mu),2)/(2*pow(sigma,2)));

			fprintf(fp,"%lf,%lf\n",s,x);
		}
			
		fclose(fp);	
		return 0;
}
