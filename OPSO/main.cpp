#include "opso.h"

/* メイン */
int main(void){
	Particle P;
	
#ifdef TIME        // 実行時間確認
	struct timeval start, end;
	gettimeofday(&start, NULL);  // 計測開始時間
#endif
   P = ExecPSO();

#ifdef TIME
	gettimeofday(&end, NULL);    // 計測終了時間
	cout << "PSOの実行時間は " << (end.tv_sec - start.tv_sec)
		+ (end.tv_usec - start.tv_usec)*1.0E-6 << "[s]でした。" << endl;


#endif	
	cout <<  Ts << "[s] " << 1/Ts << "[Hz]" << endl;
	cout << "ループ回数 " << T_MAX << endl;
	cout << "パーティクル数 " << Nparticles <<endl;
	// cout << MIN_N << "から" << MAX_N << "までで" << "最適なNは " <<  P->x_star[0] << endl;
	// cout << MIN_sig << "から" << MAX_sig << "までで" << "最適なsigは " <<  P->x_star[1] << endl;
	// cout << "ガウス関数の最適な倍数 = " << P->x_star[2] << endl;
	//cout << "最適評価値 = " << P->pbest << endl;
	return 0;
}
