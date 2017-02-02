#include "dfe.h"
#include "random"
#include "iostream"

int main(void){

//#define TOTAL 1200

	int i,TOTAL;
	//char filename[20];
	double x,mu,sigma,Ts,s;
	double ramda,delta,ipsrn,ganma;
	FILE *fp;

	Ts = 0.001;
	TOTAL = 1000;
	mu = TOTAL*Ts/2;
	sigma = 0.02;

	ramda = 0.7;
	delta = 1;
	ganma = 10;
	
		fp = fopen("johnson.dat","w");
		if(fp==NULL){
			fprintf(stderr,"Do not open error.dat");
			exit(EXIT_FAILURE);
		}
		
	   	// for(i=0; i*Ts<=(TOTAL+1)*Ts; i++){
		// 	s = Ts*i;
		// 	x = (1/sqrt(2*M_PI*sigma))*exp(-pow((s-mu),2)/(2*pow(sigma,2)));

		// 	fprintf(fp,"%lf,%lf\n",s,x);
		// }

		for(i=0; i*Ts<=(TOTAL+1)*Ts; i++){
			s = Ts*i;
			x = delta/(sqrt(2*M_PI)*ramda)*1/sqrt(1+pow((s-mu)/ramda,2))
								 *exp(-1/2*pow(ganma+delta*asinh((s-mu)/ramda),2));

			fprintf(fp,"%lf,%lf\n",s,x);
		}
			
		fclose(fp);	
		return 0;
}
