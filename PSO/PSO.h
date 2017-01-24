#ifndef PSO_H_
#define PSO_H_

#include <iostream>
#include <sys/time.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>

using namespace std;

#define TIME

/*パーティクルの構造体*/
typedef struct {
  double *x;//x_i:i番目のパーティクルの位置(N次元空間の位置x)
  double *v;//v_i:i番目のパーティクルの速度
  double f;//評価値
  double pbest;//最もよい評価値
  double *x_star;//最も評価が高い位置データ		
  double rmse;//推定値
} ParticleRec, *Particle;

//サンプリング周波数
//#define Ts 0.002 //500hz
//#define Ts 0.005 //200hz
#define Ts 0.001 //1000hz

/* パラメータの定義 */
//参考にする計測値の数とどこまでシフトさせて計測するか

//#define NUM (930*(0.001/Ts))/4 //4周期分
//#define NUM 116 // 1/4周期分500hz
//#define NUM 232 //500hz 1/2周期
//#define TOTAL 465 //1周期分500hz


#define NUM 21
#define TOTAL 999 

//#define TOTAL NUM*4 // 1周期分
#define TOTAL2 9999

//Nの最大値,最小値
//#define MAX_N 1106 //500hz 1/4周期
//#define MAX_N 232 //500hz 1/2周期

#define MIN_N 20
#define MAX_N 100
//sigの最大値,最小値
//#define MAX_sig ((MAX_N-20)/2+20)*Ts/(double)16
//#define MIN_sig ((MIN_N-20)/2+20)*Ts/(double)16

//#define MAX_sig 0.01575 //500hz 1/2周期
#define MIN_sig 1e-6
#define MAX_sig MAX_N*Ts/6.6

//真値
//#define TRUE 15.70796327//5pi
#define TRUE 2*M_PI

//パーティクルの数
#define Nparticles 100
//ループ回数
#define T_MAX 100
//慣性重み(以前の速度をどれだけ保持するのか) t=0 (W_0) t=T_MAX (W_T)
#define W_0 0.9
#define W_T 0.4
#define MAX_V_N 1
#define MAX_V_sig 0.0001

//c1は自分自身の最良の場所に重きをおいて、c2は群れの最良の場所に重みをおくか
#define c_1 1.0
#define c_2 3.0

//次元数
#define Nvariables 2

//double ew;

// int quit_flag = 0;
double GetRandom(double min,double max, int digit);

/* 評価値計算 */
void Evaluate(Particle P);

/* pbestの更新 */
void UpdateBest(Particle P);

/* それぞれのお魚さんの情報まとめ */
int Initialize(Particle P, int n);

/* 新しいデータ構造の割り当て */
#define New(type, n, msg) (type *)NewCell(sizeof(type), n, msg)
void *NewCell(int size, int n, char *msg);

/* パーティクル型のデータ構造の新しい割り当て */
Particle NewParticles(int n);

/* 発生させたお魚さんの位置と最もよい場所の表示 */
void Print(Particle P);

/* PSOの実行 */
Particle ExecPSO();

#endif
