#include <math.h>
unsigned long time;

void setup() {
  Serial.begin(9600);
}

void loop() {

  int NUM, TOTAL, i, k, t, N_sma;
  double mu, sig, sig2, sig4, Ts, z, sum1, sum2, sum3;
  double ef_sum, ef_ave, ef, check, omega, data, time_pre, data_pre, a;
  double *x, *p, *q, *d, *ef_sma;

  N_sma = 10;//単純移動平均する数
  TOTAL = 10000;//ループ回数
  omega = 2 * M_PI;//数値シミュレーションの角周波数
  NUM   = 100;//推定に使うデータ数
  mu    = NUM / (double)2;//中央値
  a     = 0.9;//データ平滑化の定数

  //t = time;
  //Serial.println(time);

  Ts = 0.01;

  x  = (double*)calloc(sizeof(double), NUM);
  p  = (double*)calloc(sizeof(double), NUM);
  q  = (double*)calloc(sizeof(double), NUM);
  ef_sma = (double*)calloc(sizeof(double), N_sma);

  //準備///////////////////////////////////////////////
  sig = (1.25 + NUM / (double)16) * Ts * 0.5;
  sig2 = sig * sig;
  sig4 = sig2 * sig2;

  for (int i = 0; i < NUM; i++) {
    p[i] = (1 / sqrt(2 * M_PI * sig2)) * exp(-1 * pow((i - mu) * Ts, 2) / (2 * sig2));
    q[i] = (pow((i - mu) * Ts, 2) - sig2) / sig4;
  }

  //推定ループ////////////////////////////////////////
  for (int t = 0; t < TOTAL; t++) {

    //
    //時間取得////////////////////////////////////////
    /*time = millis();
      Ts = (time - time_pre)*0.001;
      time_pre = time;*/

    //データ取得//////////////////////////////////////

    data = analogRead(4) - 511.6;
    data = a * data_pre + (1 - a) * data;
    data_pre = data;// Y軸*/

    //data = 100*sin(omega*t*Ts);//sin波
    //data = 2 * sin(omega * t * Ts); //sin波

    //推定///////////////////////////////////////////
    if (t < NUM) x[t] = data;

    else {

      for (int i = 1; i < NUM; i++) x[i - 1] = x[i]; //シフトさせデータをx[i]に入れる

      x[NUM - 1] = data;

      for (sum1 = 0, sum2 = 0, sum3 = 0, i = 0; i < NUM; i++) {
        sum1 += x[i] * p[i] * q[i];
        sum2 += x[i] * p[i];
        sum3 += x[i] * d[i];
      }

      check = -1 * sum1 / sum2; //推定周波数の二乗

      if (check > 0 && fabs(sum2) > 1e-6) ef = sqrt(check);

      //単純移動平均/////////////////////////////////////////////
      for (int j = 1; j <= N_sma; j++) {
        ef_sma[j - 1] = ef_sma[j];
      }
      ef_sma[N_sma] = ef;
      if (t >= (NUM + N_sma)) {
        for (int j = 0; j < N_sma; j++) {
          ef_sum += ef_sma[j];
        }
      }
      ef_ave = ef_sum / N_sma;
      ef_sum = 0;
    }
    //結果表示////////////////////////////////////////////
    Serial.print(1.35);
    Serial.print(',');
    Serial.print(data);
    Serial.print(',');
    Serial.println(ef_ave / (2 * M_PI));
    delay(10);
  }//推定ループ終わり//////////////////////////////////
}

