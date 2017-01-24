#include "fft.h"

void setup() {
  Serial.begin(9600) ;
}

void loop() {

  int WIDE, i, j, t, TOTAL;

  TOTAL = 1000;
  WIDE = 2048;

  double Ts, omega, f_fft, wave;
  double data[TOTAL], fft_data[WIDE];

  for (t = 0; t < TOTAL; t++) {

    wave = sin(2 * M_PI * t * Ts);
    data[t] = wave;

    Ts = 0.001;//[s]

    /*if (t == 32 || t == 64 || t == 128 || t == 256 || t == 512 || t == 1024 || t == 2048) {
      WIDE = t;
      fft_data  = (double*)calloc(sizeof(double), WIDE);
      for (i = 0; i < WIDE; i++) {
        fft_data[i] = data[i];
      }
      }*/

    if (t <= WIDE) fft_data[t] = wave;

    else {

      for (i = 1; i < WIDE; i++) fft_data[i - 1] = fft_data[i];
      fft_data[WIDE - 1] = wave;

    }

    //f_fft = fft(WIDE, fft_data, Ts);

    Serial.print(t);
    Serial.print(',');
    Serial.println(wave);
    delay(50);
  }
}
