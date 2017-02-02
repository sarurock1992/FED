#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>
#include <memory.h>
#include <sys/file.h>

int main(void){

	int TOTAL,j;
	double gain_l, gain_h, f_l, f_h, Ts;
	double output, input, output_1, input_1, *data;
	FILE *fp1,*fd;
	char buff[1500];

	TOTAL = 150000;
	Ts = 0.001;

	f_h = 0.5;
	gain_h = 1/(1+2*M_PI*f_h*Ts);

	f_l = 50;
	gain_l = 1/(1+2*M_PI*f_l*Ts);
	
	data   =(double*)calloc(sizeof(double),TOTAL);//計測データ

	//結果ファイル準備///////////////////////
	fp1 = fopen("brain004_new.csv","w");
	if(fp1==NULL){
		fprintf(stderr,"Do not open error.dat");
		exit(EXIT_FAILURE);
	}
	
	//// read data file ////////////////////
	//fd=fopen("../accdata/o05pi_3pi_02pi_n_1000hz.csv","r");
	//fd=fopen("../accdata/o3pi_n_1000hz.csv","r");
	fd=fopen("../accdata/brain004.csv","r");
	
	if(fd==NULL){
		fprintf(stderr,"Do not open data file\n");
		exit(EXIT_FAILURE);
	}
	for(int i=0; i<=TOTAL; i++){
		fgets(buff,1500,fd);
		sscanf(buff,"%d,%lf",&j,&data[i]);
	}
	fclose(fd);
	
	//フィルタリングループ//////////////////////////////
	for(int k=1; k<TOTAL; k++){
		
		//差分方程式でフィルタリング//////////
		output_1 = output;

		//ハイパスフィルタ	
		input  = data[k];
		input_1 = data[k-1];
		output = gain_h*input-gain_h*input_1+gain_h*output_1;

		//ローパスフィルタ
		output = gain_l*output + (1-gain_l)*output_1;
			
		fprintf(fp1,"%d,%lf,%lf\n",k,output,input);
		//fprintf(fp1,"%d,%lf,%lf,%lf,%lf,%lf\n",k,z,ef/(2*M_PI),ef_new/(2*M_PI),sum1,sum2);
		
	}//ループ終わり

	fclose(fp1);
    //printf("Ts = %lf [s], %lf [Hz]\n",Ts,1/Ts);
    //printf("N = %d, sig = %lf\n",NUM,sig);
	return 0;
}
