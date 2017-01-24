#include "mkwave.h"

int normal(void){
	int i;
	double x;
	FILE *fp;

	fp = fopen("o5pi.csv","w");
	if(fp==NULL){
		fprintf(stderr,"Do not open error.csv");
		exit(EXIT_FAILURE);
	}

	for(i=0;i<TOTAL;i++){		
		x = cos(((double)omega)*(i*((double)Ts)));
		fprintf(fp,"%d,%lf\n",i,x);
	}
	fclose(fp);
	return 0;
}

int noise(void){
	int i;
	double x;
	FILE *fp;

	fp = fopen("o5pi_noise.csv","w");
	if(fp==NULL){
		fprintf(stderr,"Do not open error.csv");
		exit(EXIT_FAILURE);
	}

	for(i=0;i<TOTAL;i++){		
		std::random_device rd;
		std::mt19937 gen(rd());
		std::uniform_real_distribution<> dis(-1, 1);		
		x = cos(omega*(i*Ts))+0.01*dis(gen);//ノイズ混入
		fprintf(fp,"%d,%lf\n",i,x);
	}
	fclose(fp);
	return 0;
}

int damp(void){

#define TOTAL 10000

	int i;
	double x;
	FILE *fp;

	fp = fopen("o5pi_damp.csv","w");
	if(fp==NULL){
		fprintf(stderr,"Do not open error.csv");
		exit(EXIT_FAILURE);
	}
	for(i=0;i<TOTAL;i++){		
		x = 0.001*i*cos(omega*(i*Ts));//振幅時間変化
		//if (i <)//途中で角周波数変化(未完)				
		fprintf(fp,"%d,%lf\n",i,x);
	}
	fclose(fp);
	return 0;
}
