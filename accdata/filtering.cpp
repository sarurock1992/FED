#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <iostream>
#include <memory.h>
#include <sys/file.h>

int main(void){

	int TOTAL,j;
	double gain_l, gain_h, f_l, f_h, Ts, data_sum,num_h;
	double out,out1,out2,in,in1,in2,*data,bias;
	double cutoff_f,bw,a0,a1,a2,b0,b1,b2,B0;
	FILE *fp1,*fd;
	char buff[1500];
	TOTAL = 150000;

	Ts = 0.01;

	f_h = 0.1;
	gain_h = 1/(1+2*M_PI*f_h*Ts);
	f_l = 15;
	gain_l = 1/(1+2*M_PI*f_l*Ts);

	cutoff_f = 10;//カットオフ周波数，通したい帯域の中央値
	bw = 1;//カットオフ周波数から前後cutoff_f*bwの周波数を通す
	B0 = 2;//尖度，大きくなるほど丸い
	
    //バンドパスフィルタ差分方程式/////////////////////////////
	a0 = 2*exp(-M_PI*B0*Ts)*cos(2*M_PI*cutoff_f*Ts);
	a1 = -exp(-2*M_PI*B0*Ts);
	a2 = 0;
	b0 = 0;
	b1 = 0;
	b2 = 0;

	printf("a0=%lf, a1=%lf, a2=%lf, b0=%lf, b1=%lf, b2=%lf\n",a0,a1,a2,b0,b1,b2);
	
	data   =(double*)calloc(sizeof(double),TOTAL);//計測データ

	//結果ファイル準備///////////////////////
	//fp1 = fopen("brain_004_new.csv","w");
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

	for (int k=1; k<TOTAL; k++){
		data_sum += data[k];
	}
	
	bias = data_sum/TOTAL;

	//printf("gain_l = %lf, gain_h = %lf, bias = %lf\n",gain_l, gain_h, bias);
	
	//フィルタリングループ//////////////////////////////
	for(int k=0; k<TOTAL; k++){
		
		//差分方程式でフィルタリング//////////
		in  = data[k];		
		
		out = a0*out1 + a1*out2  + (1-a0-a1)*in;

		num_h = (out - out1)/10;

		// for (int i=0; i<10; i++){
		// 	out = out1 + num_h*i; 
		// 	fprintf(fp1,"%d,%lf,%lf\n",10*k+i,out,in);
		// }
		
		fprintf(fp1,"%d,%lf,%lf\n",k,out,in);
		
		num_h = 0;
		out2 = out1;
		out1 = out;
		in2 = in1;
		in1 = in;
		
	}//ループ終わり

	fclose(fp1);
    //printf("Ts = %lf [s], %lf [Hz]\n",Ts,1/Ts);
    //printf("N = %d, sig = %lf\n",NUM,sig);
	return 0;
}
