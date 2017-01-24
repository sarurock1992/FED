#include "opso.h"

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
	double a,b;
	a = 10;
	b = 0.1;
	P->f = 0;
	P->f = a*P->s_error+b*P->x[0];
	
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
	int G;//もっともよいお魚さんの個体値番号
	G=0;

	for(i=0; i<n; i++) {
		for (j = 0; j<Nvariables;j++){
			if (j == 0){
				P[i].x[j] = GetRandom(MIN_N,MAX_N,6);//6まで
			}else{
				P[i].x[j] = GetRandom(MIN_sig,P[i].x[0]*Ts/6.6,6);//P[i].x[0]によって上限設定有り
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

	int t, i, j, s, m, k, n, count=0;
	Particle P;
	int G,k_count;
	double w;
	
	int N=0;//,MAX_N_new;
    //char code = -1;
	char buff[15000];//追加
	FILE *fp,*fp2,*fp3,*fp4,*fp5,*fp6;//追加
	double *x,*x1,*x2,*p,*q,*d,*data;
	double sig,sig2,sig4,check;
	double ew,error,error1,d_error;
	double mu,theta,best_theta,bestew;
	double sum1=0,sum2=0,sum3=0,dsum=0;

    //((MIN_N-20)/2+20)*Ts/(double)16;
	data=(double*)malloc(TOTAL2*sizeof(double));

	//推定結果を解析するためのデータ記入ファイルの準備
	fp=fopen("check.dat","w");
	if(fp==NULL){
	  fprintf(stderr,"Do not open error.dat");
	  exit(EXIT_FAILURE);
	}

	fp4=fopen("errorcheck.dat","w");
	if(fp==NULL){
	  fprintf(stderr,"Do not open error.dat");
	  exit(EXIT_FAILURE);
	}

	fp5=fopen("signalerror.dat","w");
	if(fp==NULL){
	  fprintf(stderr,"Do not open error.dat");
	  exit(EXIT_FAILURE);
	}

	x   =(double*)calloc(sizeof(double),NUM);//計測データ
	x1  =(double*)calloc(sizeof(double),NUM);//計測データ
	x2  =(double*)calloc(sizeof(double),NUM);
	p   =(double*)calloc(sizeof(double),NUM);///////
	q   =(double*)calloc(sizeof(double),NUM);//準備できる数値配列
	d   =(double*)calloc(sizeof(double),NUM);///////
	//plot=(double*)calloc(sizeof(double),TOTAL2);//データプロット用配列
	//p1   =(double*)calloc(sizeof(double),NUM);
	//p2   =(double*)calloc(sizeof(double),NUM);
    //pew =(double*)calloc(sizeof(double),TOTAL);//データプロット用配列
 

	//// read data file /////////////

	fp2=fopen("../accdata/o5pi_1000hz.csv","r");
	
	if(fp2==NULL){
		fprintf(stderr,"Do not open data file\n");
		exit(EXIT_FAILURE);
	}
	
 	fp3=fopen("phi_phidd.dat","w");
	if(fp3==NULL){
		fprintf(stderr,"Do not open error.dat");
		exit(EXIT_FAILURE);
	}
	
	//対象信号データ格納用配列
	for(i=0; i<=TOTAL2; i++){
		fgets(buff,1500,fp2);
		sscanf(buff,"%d,%lf",&j,&data[i]);
		//printf("%d %lf\n",i,data[i]);
	}
	
	fclose(fp2);

	fp6=fopen("data.dat","w");
	if(fp==NULL){
	  fprintf(stderr,"Do not open error.dat");
	  exit(EXIT_FAILURE);
	}
	
    //double ew;
	P = NewParticles(Nparticles);
	G = Initialize(P, Nparticles);
	w = W_0;
	error1 = 1e+10;
	
	for(t=0; t<T_MAX; t++){//パーティクル(粒子)更新ループ

		if(t%100 == 0){
			printf("%d / %d\n",t,T_MAX);
		}
		
		for(i=0; i<Nparticles; i++){//パーティクルループ
			//printf("%d / %d\r\n",i,Nparticles);
						
			for(j=0; j<Nvariables; j++){//粒子情報2次元更新
			
				P[i].v[j] = w*P[i].v[j]//パーソナルベストとグローバルベストを元に速度更新
						+ c_1*(double)rand()/RAND_MAX*(P[i].x_star[j]-P[i].x[j])
						+ c_2*(double)rand()/RAND_MAX*(P[G].x_star[j]-P[i].x[j]);

				if (j == 0){//Nの速度上限下限
						if(P[i].v[j] < -MAX_V_N){
							P[i].v[j] = -MAX_V_N;
						}
						if(P[i].v[j] > MAX_V_N){
							P[i].v[j] = MAX_V_N;
						}
					}
				
				if (j == 1){//sigmaの速度上限下限					   
					if(P[i].v[j] < -MAX_V_sig){
						P[i].v[j] = -MAX_V_sig;							
					}
					if(P[i].v[j] > MAX_V_sig){
						P[i].v[j] = MAX_V_sig;
					}
				}
				
				P[i].x[j] += P[i].v[j];
				
				if (j == 0){//Nの位置の上限下限
					P[i].x[j] = round(P[i].x[j]);
					if(P[i].x[j] < MIN_N){
						P[i].x[j] = MIN_N;//+(MIN_N-P[i].x[j]);
					}
					if(P[i].x[j] > MAX_N){
						P[i].x[j] = MAX_N;//-(P[i].x[j]-MAX_N);
					}
				}
				if (j == 1){//sigmaの位置の上限下限
					if(P[i].x[j] < MIN_sig){
						P[i].x[j] = MIN_sig;//+(MIN_sig-P[i].x[j]);
					}
					if(P[i].x[j] > P[i].x[0]*Ts/6.6){
						P[i].x[j] = P[i].x[0]*Ts/6.6;//-(P[i].x[j]-MAX_sig);
					}
				}
			}//2次元の粒子情報更新

			// if (P[i].x[0] > t ){
			// 	P[i].x[0] = t;
			// }
			
			N =  P[i].x[0];//Nの数
			sig = P[i].x[1];//超関数の分散
			mu=N/(double)2;//超関数中央値
			sig2=sig*sig;//分散の二乗
			sig4=sig2*sig2;//分散の四乗
		
			//ガウス関数
			for(m=0; m<N; m++){
				p[m]=exp(-1*pow((m-mu)*Ts,2)/(2*sig2));
				q[m]=(pow((m-mu)*Ts,2)-sig2)/sig4;
				d[m]=(m-mu)*Ts/sig2;
			}

			for (k=0;k<t;k++){
				x[k] = data[k];	
			}

			k_count = 0;

			if (N < t){//全体のループ数がNを上回っているとき
				for(k=t-N; k<t; k++){//データの先頭からN個配列に入れる
				
					if(k_count < N){
						x1[k_count]=x[k];
						k_count += 1;
					}
					fprintf(fp6,"%d %d %d %lf \n",t,N,k,x1[k]);
				}
				
			}else if(t <= N){
				for(k=0; k<N; k++){//
				
					if(k_count < t){
						x1[k_count]=x[k];
						k_count += 1;
					}
					fprintf(fp6,"%d %d %d %lf \n",t,N,k,x1[k]);
				}
			}

			// for(s=0; s<N; s++){
			// 	x[s]=x[s];//シフトさせデータをx[i]に入れる
			// 	x[N-1]=z;  
			// }
			
			for(sum1=0,sum2=0,sum3=0,s=0; s<N; s++){
				sum1+=x1[s]*p[s]*q[s];
				sum2+=x1[s]*p[s];
				sum3+=x1[s]*d[s];
				//printf("x1[%d] = %lf\n",s,x1[s]);
			}
				
			check = -1 * sum1/sum2; //推定周波数の二乗

			if (check > 0) ew=sqrt(check);
			//printf("ew = %lf\n",ew);				
			
//ここに観測値との二乗誤差=errorの定義式
						
			theta = 0;
			dsum = 0;
			
			for (s=0; s<100; s++){
				for (j=0; j<=N; j++){
					dsum += fabs(cos(ew*Ts*j-theta)-x1[j]);
				}
				if (dsum < 0.1){
					break;
				}
				theta = theta + 0.1*dsum;
				//printf("dsum = %lf theta = %lf\n",dsum,theta);
				dsum = 0;
			}
			
			d_error = 0;
			error = 0;
			
			for (n=0; n<N; n++){	
				d_error = cos(ew*Ts*n-theta)-x1[n];
				error += pow(d_error,2);
			}
				
			if (error <  error1){
				bestew = ew;
				error1 = error;
				best_theta = theta;
				for (n=0; n<=N; n++){	
					x2[n] = x1[n];
				}
				
				for (j=0; j<P[G].x_star[0]; j++){	
					fprintf(fp5,"%d %d %lf %lf %lf %d\n",
							count,j,best_theta,cos(ew*Ts*j-best_theta),x2[j],t);
					count += 1;
				}
				//best_N = N;
			}			
			
			//printf("error= %lf\n",error);
			
			//rmse = sqrt(pow((ew-TRUE),2));
			//rmse = sqrt(ew_rmse/P[i].x[0]);

			P[i].s_error = error;
			//printf("P[%d].s_error = %lf\n",i,P[i].s_error);
			//ew_rmse = 0;//初期化
			P->x[0] = P[i].x[0];
			Evaluate(&P[i]);
		
			if (t == 0){//1ループ目のみ
				//P[i].pbest = P[i].f;//PSO
				
				if (i == 0){//OPSO
					P[G].f = P[0].f;
				}
				
				if (i > 0){
					if(P[i].f < P[G].f){//OPSOこのループで最良の場合
						//if(P[i].f < P[i-1].f){//PSO
						G = i;
						//bestew = bestew;
						UpdateBest(&P[i]);
					}
					P[i].f_pre = P[i].f;//OPSO次の為に保存
				}
				
			}else{
				if (i == 0){//OPSO
					P[G].f = P[0].f;
				}
				
				if(P[i].f < P[i].f_pre){//OPSO
				 	if(P[i].f < P[G].f){//OPSO
				// if(P[i].f < P[i].pbest){//PSO
				// 	if(P[i].f < P[G].pbest){//PSO
						G = i;
						//bestew = bestew;
					}
					UpdateBest(&P[i]);
				}
				P[i].f_pre = P[i].f;//OPSO次の為に保存
			}
			
		}//パーティクルループ終わり
		
		for (i =0;i<Nparticles;i++){
			
			if(i<Nparticles-1){
				fprintf(fp,"%d %.0lf %lf %lf %.0lf %lf %lf\n",
						t,P[i].x[0],P[i].x[1],P[i].f,P[G].x_star[0],P[G].x_star[1],P[G].pbest);
			}
		
			else{//プロットのためのインデックス作成用段落
				fprintf(fp,"%d %.0lf %lf %lf %.0lf %lf %lf\n\n\n",
						t,P[i].x[0],P[i].x[1],P[i].f,P[G].x_star[0],P[G].x_star[1],P[G].pbest);
			}
		
		}

		w -= (W_0-W_T)/T_MAX;

		fprintf(fp4,"%d %lf %lf %lf\n",t, P[G].x_star[0], P[G].x_star[1], P[G].pbest);
        
		//best_N = 0;
		//best_theta = 0;
		//printf("bestew = %lf\n",bestew);
		
	}//発生ループ終わり

	P->pbest = P[G].pbest;
	for (j = 0;j<Nvariables;j++){
		P->x_star[j] = P[G].x_star[j];
	}
	//printf("真値= %lf, 推定値= %lf\n",TRUE,bestew);
	//printf("相対誤差 = %lf％\n",sqrt(pow((TRUE-bestew),2))/((double)TRUE)*100);
//fclose(fp);
	fclose(fp3);
	fclose(fp4);
	fclose(fp5);
	fclose(fp6);
	return P;
}

