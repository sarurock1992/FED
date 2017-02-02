#include <math.h>
#include <stdio.h>
#include <iostream>
#include <stdlib.h>
#include <string.h>
#include <memory.h>
#include <sys/file.h>

using namespace std;

#define TOTAL 1000
#define initN 100//最初のN
#define Ts 0.01
//#define TOTAL NUM*4 // 1周期分
#define TOTAL2 1000//信号データ配列サイズ
#define MIN_N 20
//#define MAX_N 100
//sigの最大値,最小値
#define MIN_sig 1e-6
#define MAX_sig 0.015
//パーティクルの数
#define Nparticles 10
//慣性重み(以前の速度をどれだけ保持するのか) t=0 (W_0) t=T_MAX (W_T)
#define W_0 0.8
#define W_T 0.4
#define MAX_V_N 1
#define MAX_V_sig 0.0001

//c1は自分自身の最良の場所に重きをおいて、c2は群れの最良の場所に重みをおくか
#define c_1 9.0
#define c_2 1.0
//次元数
#define Nvariables 2

double fed(double *data, int NUM, double sig, double mu);

/*パーティクルの構造体*/
typedef struct {
	double *x;//x_i:i番目のパーティクルの位置(N次元空間の位置x)
	double *v;//v_i:i番目のパーティクルの速度
	double f;//評価値
	double f_pre;//各粒子の一つ前の評価値
	double pbest;//最もよい評価値
	double *x_star;//最も評価が高い位置データ		
	double s_error;//推定値
} ParticleRec, *Particle;

double GetRandom(double min,double max, int digit);

/* 評価値計算 */
void Evaluate(Particle P);

/* pbestの更新 */
void UpdateBest(Particle P);

/* それぞれのお魚さんの情報まとめ */
int Initialize(Particle P, int n, int MAX_N);

/* 新しいデータ構造の割り当て */
#define New(type, n, msg) (type *)NewCell(sizeof(type), n, msg)
void *NewCell(int size, int n, char *msg);

/* パーティクル型のデータ構造の新しい割り当て */
Particle NewParticles(int n);

/* 発生させたお魚さんの位置と最もよい場所の表示 */
void Print(Particle P);

/* OPSOの実行 */
Particle OPSO(double ef, double *data, int MAX_N);



