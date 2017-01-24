
#include "dfe.h"

#define N 1000

char buff[1500];
FILE *fd, *fp;
double Q = 0.00001; //システム雑音
double R = 0.01; //環境雑音
int i, j, k, x;
double xhat[N], xhat_new[N], g[N], y[N], p[N], p_new[N]; //変数

int main(){

	xhat[0] = 0;
	xhat_new[0] = 0.0;
	g[0] = 0.0;
	y[0] = 0.0;
	p[0] = 0.0;
	p_new[0] = 0.0;

	fd=fopen("dfe.dat","r");

  if(fd==NULL){
    fprintf(stderr,"Do not open data file");
    exit(EXIT_FAILURE);
  }

  fp=fopen("Kalman.dat","w");
  if(fp==NULL){
    fprintf(stderr,"Do not open error.dat");
    exit(EXIT_FAILURE);
  }

  for( k =0; k <= N; k++ ){
    fgets(buff,1500,fd);
    sscanf(buff,"%d,%lf",&j,&y[k]);
    //printf("%d %lf\n",k,y[k]);
  }
  fclose(fd);

	//printf("\n KF : origine \n");
	
	xhat_new[0] = y[0];
	
		for (i = 1; i <= N; i++)
		{
			xhat[i] = xhat_new[i-1];
			p[i] = p_new[i-1] + Q;
			g[i] = p[i] / ( p[i] + R );
			xhat_new[i] = xhat[i] + g[i] * ( y[i] - xhat[i] );
			p_new[i] = ( 1 - g[i] ) * p[i];

			printf(" %f : %f \n",xhat_new[i], y[i]);
		
      fprintf(fp,"%d, %lf, %lf \n", i, xhat_new[i], y[i]);
		}

	fclose(fp);
	return 0;
}
