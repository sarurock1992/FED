#include "fed.h"

double fed(double *data, int NUM, double sig, double mu){
   
	double sum1=0,sum2=0,check,sig2,sig4;
	double ef,*p,*q;
	// a1 = 0.9;
	// a2 = 0.9;
	p = (double*)calloc(sizeof(double),NUM);//一回微分
	q = (double*)calloc(sizeof(double),NUM);//二回微分

	sig2=sig*sig;
	sig4=sig2*sig2;

    //ガウス関数////////////////////////////
	for(int i=0; i<NUM; i++){
		p[i]=(1/sqrt(2*M_PI*sig2))*exp(-1*pow((i-mu)*Ts,2)/(2*sig2));
		q[i]=(pow((i-mu)*Ts,2)-sig2)/sig4;
	}
	
	for(int i=0; i<NUM; i++){
		sum1+=(*data)*p[i]*q[i];
		sum2+=(*data)*p[i];
		data++;
	}
	
	check = -1 * sum1/sum2; //推定周波数の二乗
	if (check>0 && fabs(sum2)>1e-6){
	//if (check>0 && fabs(sum2)>1e-6 && last_sum1*sum1>0 && last_sum2*sum2 >0 ){
		ef=sqrt(check);
	}
	return ef;
}

double GetRandom(double min,double max,int digit){
	double ten,R;
	int srand_flag;

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
	b = 0.001;
	P->f = 0;
	P->f = a*P->s_error+b*P->x[0];
}

/* pbestの更新 */
void UpdateBest(Particle P){
	for(int j=0; j<Nvariables; j++){
		P->x_star[j] = P->x[j];
	}
	P->pbest = P->f;
}

/* それぞれのお魚さんの情報まとめ */
int Initialize(Particle P, int n, int MAX_N){
	int i,j,G;
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
	for(int j=0; j<Nvariables; j++){
		printf("%f ", P->x_star[j]);
	}
	printf(" = %g\n", P->pbest);
}

Particle OPSO(double ef, double *data, int MAX_N){
	
	int N,G;
	Particle P;
	double w,error,d_error,theta,dsum=0;
   
	P = NewParticles(Nparticles);
	G = Initialize(P, Nparticles, MAX_N);
	w = W_0;
	
	for(int i=0; i<Nparticles; i++){//パーティクルループ
						
		for(int j=0; j<Nvariables; j++){//粒子情報2次元更新
			
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

		N =  P[i].x[0];//Nの数						
		theta = 0;
		dsum = 0;
			
		for (int s=0; s<100; s++){//thetaを勾配法で調整
			
			for (int j=0; j<N; j++){
				dsum += fabs(cos(ef*Ts*j-theta)-(*data));
				data++;
			}
			for (int j=0; j<N; j++){
				data--;
			}
			
			if (dsum < 0.1){//誤差が0.1未満になったらbreak
				break;
				cout <<"break"<<endl;
			}			
			theta = theta + 0.1*dsum;
			dsum = 0;
		}

		d_error = 0;
		error = 0;
		   
		for (int n=0; n<N; n++){//theta調整後の誤差の合計	
			d_error = sin(ef*Ts*n-theta)-(*data);
			error += pow(d_error,2);
			data++;
		}
		for (int j=0; j<N; j++){
			data--;
		}
		
		P[i].s_error = error;

		P->x[0] = P[i].x[0];
		
		Evaluate(&P[i]);

		cout << "i=" << i <<" error= " << error << " N= " << P->x[0] << endl;
		
		if (i == 0){//OPSO
			P[G].f = P[0].f;
		}
				
		if(P[i].f < P[i].f_pre){//OPSO
			if(P[i].f < P[G].f){//OPSO
				G = i;
			}
			UpdateBest(&P[i]);
		}
		
		P[i].f_pre = P[i].f;//OPSO次の為に保存
	
			
	}//パーティクルループ終わり
	cout << "G=" << G << endl;
		
	w -= (W_0-W_T)/TOTAL;

	P->pbest = P[G].pbest;
	
	for (int j = 0;j<Nvariables;j++){
		P->x_star[j] = P[G].x_star[j];
	}
	//printf("真値= %lf, 推定値= %lf\n",TRUE,bestew);
	//printf("相対誤差 = %lf％\n",sqrt(pow((TRUE-bestew),2))/((double)TRUE)*100);
	
	return P;
}

