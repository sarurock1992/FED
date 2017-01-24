#include "PSO.h"
#include "dfe.h"

double GetRandom(double min,double max,int digit){
	double ten,R;
	static int srand_flag;

	if (srand_flag == 0) {
		srand((unsigned int)time(NULL));
		srand_flag = 1;
	}
	ten = pow(10,digit-1);
	R = min*ten + (int)(rand()*((max-min)*ten+1.0)/(1.0+RAND_MAX));
	return R/ten;
}

/* 評価値計算 */
//void Evaluate(Particle P){
void Evaluate(Particle P){
	P->f = 0;
	P->f = P->rmse*P->x[0];
	//P->f = P->rmse+P->x[0];
	
}

/* pbestの更新 */
int j;
void UpdateBest(Particle P){
	for(j=0; j<Nvariables; j++){
		P->x_star[j] = P->x[j];
	}
	P->pbest = P->f;
}

/* それぞれのお魚さんの情報まとめ */
int Initialize(Particle P, int n){
	int i,j;
	int G;
//もっともよいお魚さんの個体値番号
	G=0;

	for(i=0; i<n; i++) {
		for (j = 0; j<Nvariables;j++){
			if (j == 0){
				P[i].x[j] = GetRandom(MIN_N,MAX_N,6);//6まで
			}else{
				P[i].x[j] = GetRandom(MIN_sig,MAX_sig,6);//6まで
			}
			P[i].v[j] = 0;//GetRandom(min,max,16)*((MIN_sig+MAX_sig)/2);
		}
		Evaluate(&P[i]);
		UpdateBest(&P[i]);
		
		if(P[i].f < P[G].f){ //Gよりもi番目の評価値がよかったら(小さかったら)Gをiに代入
			G = i;
		}
	}
	return G;
}
/* 新しいデータ構造の割り当て */
//#define New(type, n, msg) (type *)NewCell(sizeof(type), n, msg)

void *NewCell(int size, int n, char *msg){
	void *NEW;
	//newの要素をn個分確保して、それがNULLだったらerrorを返す
	
	if((NEW=malloc(size*n))==NULL){
		fprintf(stderr, "Cannot allocate memory for %d %s\n", n, msg);
		exit(1);
	}
	return NEW;
}

/* パーティクル型のデータ構造の新しい割り当て */
Particle NewParticles(int n){
	int i;
	Particle P;

	P = New(ParticleRec, n, (char*)"particles");
	for(i=0; i<n; i++){
		P[i].x = New(double, Nvariables, (char*)"x");
		P[i].v = New(double, Nvariables, (char*)"v");
		P[i].x_star = New(double, Nvariables, (char*)"x*");
	}
	return P;
}

/* 発生させたお魚さんの位置と最もよい場所の表示 */
void Print(Particle P){
	int j;

	for(j=0; j<Nvariables; j++){
		printf("%f ", P->x_star[j]);
	}
	printf(" = %g\n", P->pbest);
}

Particle ExecPSO(){

	int t, i, j, s, m, k=0;
	Particle P;
	int G;
	double w;
	
	int N=0;
//	char code = -1;
	char buff[1500];//追加
	FILE *fp,*fp2,*fp3,*fp4;//追加
	double *x,*p,*q,*d,*plot,*data,*p1,*p2;
	double z;
	double ew,ew_rmse,rmse,bestew,error,error1;
	double mu;
	double sum1=0,sum2=0,sum3=0;
	double sig;
//((MIN_N-20)/2+20)*Ts/(double)16;
	double check;//sigma
	double sig2;
	double sig4;
	data=(double*)malloc(TOTAL2*sizeof(double));

// #define GNUPLOT
// #ifdef GNUPLOT

	// 	//テスト関数記入ファイルの準備
	// fp3=fopen("phi_phidd.dat","w");
	// if(fp==NULL){
	//   fprintf(stderr,"Do not open error.dat\n");
	//   exit(EXIT_FAILURE);
	// }
  
	//推定結果記入ファイルの準備
	// 	fp=fopen("dfe_test.dat","w");
	// if(fp==NULL){
	//   fprintf(stderr,"Do not open error.dat");
	//   exit(EXIT_FAILURE);
	// }

	//推定結果を解析するためのデータ記入ファイルの準備
	fp=fopen("check.dat","w");
	if(fp==NULL){
	  fprintf(stderr,"Do not open error.dat");
	  exit(EXIT_FAILURE);
	}

	x   =(double*)calloc(sizeof(double),NUM);//計測データ
	p   =(double*)calloc(sizeof(double),NUM);///////
	q   =(double*)calloc(sizeof(double),NUM);//準備できる数値配列
	d   =(double*)calloc(sizeof(double),NUM);///////
	plot=(double*)calloc(sizeof(double),TOTAL2);//データプロット用配列
	p1   =(double*)calloc(sizeof(double),NUM);
	p2   =(double*)calloc(sizeof(double),NUM);
//  pew =(double*)calloc(sizeof(double),TOTAL);//データプロット用配列
 

   
  //// read data file /////////////
  //fd=fopen("../accdata/1000.csv","r");//振り子角速度1000Hz

  fp2=fopen("../accdata/o2pi_1000hz.csv","r");

  //fd=fopen("../accdata/sinmat10hz.csv","r");//f=10hz
  //fd=fopen("../accdata/sinmat-d10hz.csv","r");//f=10hzの小数点以下6ケタまでの離散化データ
  //fd=fopen("../accdata/sinmat-d10hztest.csv","r");//f=10hzの小数点以下6ケタまでの離散化データ
  //fd=fopen("../accdata/coswave.csv","r");//cos波1000Hz,omega=6.75
  //fd=fopen("../accdata/err1.dat","r");//sin波100Hz

	if(fp2==NULL){
		fprintf(stderr,"Do not open data file\n");
		exit(EXIT_FAILURE);
	}
	
 	fp3=fopen("phi_phidd.dat","w");
	if(fp3==NULL){
		fprintf(stderr,"Do not open error.dat");
		exit(EXIT_FAILURE);
	}

	fp4=fopen("errorcheck.dat","w");
	if(fp==NULL){
	  fprintf(stderr,"Do not open error.dat");
	  exit(EXIT_FAILURE);
	}
	
	//printf("check3");
	for(i=0; i<=TOTAL2; i++){
		fgets(buff,1500,fp2);
		sscanf(buff,"%d,%lf",&j,&data[i]);
		//printf("%d %lf\n",i,data[i]);
	}
	
	fclose(fp2);
	
//	double ew;
	P = NewParticles(Nparticles);
	G = Initialize(P, Nparticles);
	w = W_0;
	error1 = 1e+10;

	for(t=1; t<=T_MAX; t++){//パーティクル(粒子)更新ループ

		printf("%d / %d\r\n",t,T_MAX);
		
		for(i=0; i<Nparticles; i++){//パーティクルループ

			for(j=0; j<Nvariables; j++){//粒子情報2次元更新

					P[i].v[j] = w*P[i].v[j]
						+ c_1*(double)rand()/RAND_MAX*(P[i].x_star[j]-P[i].x[j])
						+ c_2*(double)rand()/RAND_MAX*(P[G].x_star[j]-P[i].x[j]);
					if (j == 0){
						if(P[i].v[j] < -MAX_V_N){
							P[i].v[j] = -MAX_V_N;
							
						}if(P[i].v[j] > MAX_V_N){
							P[i].v[j] = MAX_V_N;
						}
					}
					if (j == 1){
						if(P[i].v[j] < -MAX_V_sig){
							P[i].v[j] = -MAX_V_sig;
							
						}if(P[i].v[j] > MAX_V_sig){
							P[i].v[j] = MAX_V_sig;
						}
					}

					P[i].x[j] += P[i].v[j];
					
					if (j == 0){
						P[i].x[j] = round(P[i].x[j]);
						if(P[i].x[j] < MIN_N){
							P[i].x[j] = MIN_N;//+(MIN_N-P[i].x[j]);
						}
						if(P[i].x[j] > MAX_N){
							P[i].x[j] = MAX_N;//-(P[i].x[j]-MAX_N);
						}
					}
					if (j == 1){
						if(P[i].x[j] < MIN_sig){
							P[i].x[j] = MIN_sig;//+(MIN_sig-P[i].x[j]);
						}
						if(P[i].x[j] > MAX_sig){
							P[i].x[j] = MAX_sig;//-(P[i].x[j]-MAX_sig);
						}
					}
			}//2次元の粒子情報更新
	
			N =  P[i].x[0];//Nの数
			sig = P[i].x[1];//超関数の分散
			mu=N/(double)2;//超関数中央値
			sig2=sig*sig;//分散の二乗
			sig4=sig2*sig2;//分散の四乗
		
//			ガウス関数
			for(m=0; m<N; m++){			
				p[m]=exp(-1*pow((m-mu)*Ts,2)/(2*sig2));
				q[m]=(pow((m-mu)*Ts,2)-sig2)/sig4;
				d[m]=(m-mu)*Ts/sig2;
			}
//printf("p[%d]=%lf\n",m,p[m]);
				
//二回微分と四回微分使用
				// p[m]=exp(-1*pow((m-mu)*Ts,2)/(2*sig2));
				// q[m]=(pow((m-mu)*Ts,2)-sig2)/sig4;
				// d[m]=(m-mu)*Ts/sig2;
				// p1[m]=4*(m-mu)*Ts/sig4;
				// p2[m]=2*p[m]/sig4-p1[m]*d[m]*p[m]+p[m]*p[m]*q[m];
			
			//隆起関数			
			// double a,b,c;
			// N = P[i].x[0];//Nの数
			// a = P[i].x[2];
			// b = P[i].x[3];
			// c = P[i].x[4];
		
			// for(m=0; m<N; m++){
			
			// 	p[m]=c*exp(-a/(pow(b,2)-pow(2*b/(double)NUM*m-b,2)));
			// 	q[m]=pow(c,2)*(6*a*pow(2*b/(double)NUM*m-b,4)+4*a*(a-pow(b,2))*pow((2*b/(double)NUM*m-b),2)-2*a*pow(b,2))/pow(pow(b,2)-pow((2*b/(double)NUM*m-b),2),4);
			
			// 	if (p[m] == 0){
			// 		q[m] = 0;
			// 	}
			// 	//printf("p[%d]=%lf\n",i,p[i]);
			// 	//fprintf(fp3,"%d,%lf,%lf\n",i,p[i],q[i]);
			// }
			
			for(k=0; k<=TOTAL+N; k++){//
				//	printf("ew =%lf\n",ew);
				//printf("data[%d] =%lf\n",k,data[k]);
				plot[k]=z=data[k];
			
				if(k<N){
					
					x[k]=z;
					
				}else {
					
					for(s=1; s<N; s++){
						x[s-1]=x[s];//シフトさせデータをx[i]に入れる
						x[N-1]=z;  
					}
					
					for(sum1=0,sum2=0,sum3=0,s=0; s<N; s++){
						sum1+=x[s]*p[s]*q[s];
						sum2+=x[s]*p[s];
						sum3+=x[s]*d[s]; 
//二回微分と四回微分使用
						// sum1+=x[s]*p2[s];
						// sum2+=x[s]*p[s]*q[s];
						// sum3+=x[s]*d[s];
					}
					//printf("sum1=%f, N= %d\n",sum1,N);
					check = -1 * sum1/sum2; //推定周波数の二乗
					if (check>0 && fabs(sum2)>1e-6){
					ew=sqrt(check);
					}				
				}
				
				error = pow(ew-((double)TRUE),2);//相対誤差
				
				ew_rmse += error;//相対誤差の累積
				
				if (error <  error1){
					bestew = ew;
					error1 = error;
				}
			}			
			//rmse = sqrt(pow((ew-TRUE),2));
			rmse = sqrt(ew_rmse/P[i].x[0]);

			P[i].rmse = rmse;
			ew_rmse = 0;//初期化
			P->x[0] = P[i].x[0];
			Evaluate(&P[i]);
						
			if (t==1){
				P[i].pbest = P[i].f;
				if (i>0){
					if(P[i].f < P[i-1].f){
						G = i;
						bestew = bestew;
						UpdateBest(&P[i]);
					}
				}
			}
		
			if(P[i].f < P[i].pbest){
				if(P[i].f < P[G].pbest){
					G = i;
					bestew = bestew;
					//printf("グローバルベストが更新されました．\n");
				}
				UpdateBest(&P[i]);
			}
// 			printf("G = %d \n",G);
//			printf ("RMSE %lf \n",P[i].rmse);
// 			printf ("P[%d].f = %lf ",i,P[i].f);
//			printf ("P->f = %lf \n",P->f);
// 			printf ("P[%d].pbest = %lf ",i,P[i].pbest);
//			printf ("P[%d].ew = %lf ",i,P[i].ew);
//			printf ("P->pbest = %lf \n",P->pbest);
//			printf ("P[%d].x[0] = %lf ",i,P[i].x[0]);
//			printf ("P->x[0] = %lf\n",P->x[0]);

// 			printf ("P->x_star[0] = %lf",P->x_star[0]);
// 			printf ("P->x_star[1] = %lf\n",P->x_star[1]);
//			fprintf(fp,"%d  %d,%.0lf,%.15lf,%lf\n",t,i,P[i].x[0],P[i].x[1],P[i].f
			
		}//パーティクルループ終わり

		for (i =0;i<Nparticles;i++){
			if(i<Nparticles-1){
				fprintf(fp,"%d %.0lf %lf %lf %.0lf %lf %lf\n",
						//P[i].x[0],P[i].x[1],P[i].f,P->x_star[0],P->x_star[1],P->pbest);
						t,P[i].x[0],P[i].x[1],P[i].f,P[G].x_star[0],P[G].x_star[1],P[G].pbest);
			}

			else{//プロットのためのインデックス作成用段落
				fprintf(fp,"%d %.0lf %lf %lf %.0lf %lf %lf\n\n\n",
						//P[i].x[0],P[i].x[1],P[i].f,P->x_star[0],P->x_star[1],P->pbest);
						t,P[i].x[0],P[i].x[1],P[i].f,P[G].x_star[0],P[G].x_star[1],P[G].pbest);
			}
		}			
		w -= (W_0-W_T)/T_MAX;
		//printf("bestew = %lf\n",bestew);
		fprintf(fp4,"%d %.0lf %lf %lf %lf\n",t,P[G].x_star[0],P[G].x_star[1],P[G].pbest,sqrt(pow((TRUE-bestew),2))/((double)TRUE)*100);
	}//発生ループ終わり

	P->pbest = P[G].pbest;
	for (j = 0;j<Nvariables;j++){
		P->x_star[j] = P[G].x_star[j];
	}
	
	printf("真値= %lf, 推定値= %lf\n",TRUE,bestew);
	printf("相対誤差 = %lf％\n",sqrt(pow((TRUE-bestew),2))/((double)TRUE)*100);
	//fclose(fp);
	fclose(fp3);
	fclose(fp4);
	return P;
}

