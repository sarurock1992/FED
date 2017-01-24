#include "mkwave.h"
/* メイン */
int main(void){
	normal();
//	noise();
//	damp();
   
   printf("サンプリング周期=%d[Hz]\n角周波数omega=%lf[rad/s]\n正弦波の周期=%lf[s]\n",
	 	   s_hz,omega,omega/2/M_PI);
	return 0;
}
