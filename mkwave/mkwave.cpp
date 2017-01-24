#include "dfe.h"
#include "random"
#include "iostream"

int main(void){

//#define TOTAL 1200

	int i,SIZE;//,s_hz;
	//char filename[20];
	double x,Ts,omega,omega2,omega3;//,change_s;//,omega2,omega_c,a,b,t1,t2,t3,t4,t5,t6,t7;
	FILE *fp;

	omega = 0.5*2*M_PI;//デルタ波
	omega2 = 3*2*M_PI;
	omega3 = 0.2*2*M_PI;
	//s_hz = 1000;
	Ts = 0.001;//[s]
	//TERM = 2;
	SIZE = 10000;
	//SIZE2 = 700;
	//change_s = 2*M_PI/(Ts*omega);
	//change_o = 1/(Ts*change_s*(2*M_PI/omega));

	//printf("change_s = %lf\n",change_s);
	//t1 = 100;
	//a = (omega2/omega-1)/(t2-t1);
	//b = 1-a*t1;
	
	//printf("a = %lf b = %lf\n",a,b);
	// for (k = 0; k<100; k++){
	// 	sprintf(filename, "2pi*%d_1000hz.csv", k+1);
	// 	fp = fopen(filename,"w");
	// 	if(fp==NULL){
	// 		fprintf(stderr,"Do not open error.csv");
	// 		exit(EXIT_FAILURE);
	// 	}
		fp = fopen("o3pi_n_1000hz.csv","w");
		if(fp==NULL){
			fprintf(stderr,"Do not open error.csv");
			exit(EXIT_FAILURE);
		}

		std::random_device rd;
		std::mt19937 gen(rd());
		std::uniform_real_distribution<> dis(-1, 1);
		//x = cos(omega*(i*Ts))+0.01*dis(gen);//ノイズ混入
		
	   	for(i=0; i<SIZE; i++){//周波数変化
			
			if (i < 3000){
				x = cos((double)omega2*(i*(double)Ts))+0.01*dis(gen);
			}else if (i >= 3000 && i < 6000){
				x = cos((double)omega2*(i*(double)Ts));//+0.01*dis(gen);
			}else {
				x = cos((double)omega3*(i*(double)Ts));//+0.01*dis(gen);
			}
			fprintf(fp,"%d,%lf\n",i,x);
		}
		
		// for(i=0; i<SIZE; i++){//違う周波数が混在
			
		// 	x = cos((double)omega*(i*(double)Ts));//+0.05*dis(gen);
			
		// 	fprintf(fp,"%d,%lf\n",i,x);
		// }
		

		fclose(fp);	
			// 	omega = omega+2*M_PI;
		
		
		//printf("サンプリング周期=%d[Hz]\n角周波数omega=%lf[rad/s]\n正弦波の周期=%lf[s]\n",s_hz,omega,omega/2/M_PI);
		return 0;
}
