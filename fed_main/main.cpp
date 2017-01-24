#include "fed.h"

int main(void){

	int N,j,N_sma;
	N = 200;
	FILE *fp1,*fp2,*fd;
	char buff[1500];
	double *x,*data,*ef_sma,*p,*q,ef_sum,ef_ave,ef_ave_pre,ef,z,last_z,a;//pbest;
	double mu=N/(double)2;
	double sig=(1.25+N/(double)16)*Ts*0.5;
	double sum1=0,sum2=0,check,sig2,sig4;

	N_sma = 20;//単純移動平均するデータ数
	a = 0.9;//差分方程式の重み
	sig2=sig*sig;
	sig4=sig2*sig2;
	
	data   =(double*)calloc(sizeof(double),TOTAL);//計測データ
	x      =(double*)calloc(sizeof(double),N);//推定に使う配列
	ef_sma =(double*)calloc(sizeof(double),N_sma);//推定に使う配列
	p      = (double*)calloc(sizeof(double),N);//一回微分
	q      = (double*)calloc(sizeof(double),N);//二回微分
	//static double sig = 0.003832;//PSOで求めた最適パラメータ	

	//結果ファイル準備///////////////////////
	fp1 = fopen("fed.dat","w");
	if(fp1==NULL){
		fprintf(stderr,"Do not open error.dat");
		exit(EXIT_FAILURE);
	}
	
	fp2 = fopen("differential.dat","w");
	if(fp2==NULL){
		fprintf(stderr,"Do not open error.dat");
		exit(EXIT_FAILURE);
	}
	
	//// read data file ////////////////////
	fd=fopen("../accdata/o05pi_3pi_02pi_n_1000hz.csv","r");
	//fd=fopen("../accdata/o3pi_n_1000hz.csv","r");
	//fd=fopen("../accdata/brain02.csv","r");
	
	if(fd==NULL){
		fprintf(stderr,"Do not open data file\n");
		exit(EXIT_FAILURE);
	}
	for(int i=0; i<=TOTAL; i++){
		fgets(buff,1500,fd);
		sscanf(buff,"%d,%lf",&j,&data[i]);
	}
	fclose(fd);

    //ガウス関数////////////////////////////
	for(int i=0; i<N; i++){
		p[i]=(1/sqrt(2*M_PI*sig2))*exp(-1*pow((i-mu)*Ts,2)/(2*sig2));
		q[i]=(pow((i-mu)*Ts,2)-sig2)/sig4;
	}
	
	//推定ループ//////////////////////////////
	for(int k=0; k<TOTAL; k++){
		//cout << "k=" << k << endl;

		//差分方程式でフィルタリング//////////
		z = data[k];
		z = a*z + (1-a)*last_z;
		last_z = z;

		if(k<N) x[k]=z;
		
		//推定開始/////////////////////////////
		else {
			for (int j=1; j<=N; j++){
				x[j-1] = x[j];
			}
			x[N]=z;
		
			//推定////////////////////////////////
			//ef = dfe(x,N,sig,mu);
			sum1 = 0; sum2 = 0;
			
			for(int i=0; i<N; i++){
				sum1+= x[i]*p[i]*q[i];
				sum2+= x[i]*p[i];
			}
			
			check = -1 * sum1/sum2; //推定周波数の二乗
			if (check>0 && fabs(sum2)>1e-3){
				//if (check>0 && fabs(sum2)>1e-6 && last_sum1*sum1>0 && last_sum2*sum2 >0 ){
				ef=sqrt(check);
			}
			
			//移動平均////////////////////////////
			for (int j=1; j<=N_sma; j++){
				ef_sma[j-1] = ef_sma[j];
			}
			ef_sma[N_sma] = ef;
			if (k >= (N+N_sma)){	
				for (int j=0; j<N_sma; j++){
					ef_sum += ef_sma[j];
				}
			}
		ef_ave = ef_sum/N_sma;
		ef_sum = 0;
		
		//OPSO//////////////////////////////////
		/*P = OPSO(ef,x,k,best_no);
		  
		  N =  P->x_star[0];//Nの数
		  sig = P->x_star[1];//超関数の分散
		  pbest = P->pbest;
		  mu=N/(double)2;//超関数中央値*/
		}
		fprintf(fp1,"%d,%lf,%lf,%lf,%lf\n",k,z,ef_ave/(2*M_PI),sum1,sum2);
		fprintf(fp2,"%d,%lf,%lf\n",k,z,(ef_ave - ef_ave_pre)/Ts);
		ef_ave_pre = ef_ave;
		//fprintf(fp1,"%d,%lf,%lf\n",k,z,ef/(2*M_PI));
	
	}//推定ループ終わり

	fclose(fp1); fclose(fp2);
    //printf("Ts = %lf [s], %lf [Hz]\n",Ts,1/Ts);
    //printf("N = %d, sig = %lf\n",NUM,sig);
	return 0;
}
