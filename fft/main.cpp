#include "fft.h"

int bitr( int bit, int r ){
	int i,bitr;

	bitr = 0;
	for (i=0; i<r; i++){
		bitr <<= 1;
		bitr |= (bit & 1);
		bit  >>= 1;
	}
	return( bitr );
}

void swap( complex *d0, complex *d1 ){

	double a;

	a     = d0->r;
	d0->r = d1->r;
	d1->r = a;
	a     = d0->i;
	d0->i = d1->i;
	d1->i = a;

}

int main(void){

	int SIZE, N, j, i, n, k, r, j1, j2, p, k1, bit,k_max;
	double Ts, z, a, b, amp_max, v_window;
	FILE *fp,*fp1,*fd;
	char buff[1500];
	complex *x;

	N = 256;
	Ts = 0.01;//[s]
	SIZE = 1000;
	double signal_data[SIZE], signal_data_for_fft[SIZE], amp[SIZE];

	//fd=fopen("../accdata/o05pi_3pi_02pi_n_1000hz.csv","r");
	fd=fopen("../accdata/brain004_new.csv","r");
	//fd=fopen("../accdata/o3pi_1000hz.csv","r");

	if(fd==NULL){
		fprintf(stderr,"Do not open data file\n");
		exit(EXIT_FAILURE);
	}

	for(int i=0; i<SIZE; i++){
		fgets(buff,1500,fd);
		sscanf(buff,"%d,%lf",&j,&signal_data[i]);	
	}
	fclose(fd);
	
	fp = fopen("fft_log.dat","w");
	if(fp==NULL){
		fprintf(stderr,"Do not open error.csv");
		exit(EXIT_FAILURE);
	}

	fp1 = fopen("fft_heat.dat","w");
	if(fp1==NULL){
		fprintf(stderr,"Do not open error.csv");
		exit(EXIT_FAILURE);
	}

	//メインループ////////////////////////////////////////////////////////////
	for (int s=0; s<SIZE; s++){

		if (s%100==0){
			cout << "s = " << s << endl;
		}

		
		z = signal_data[s];
		//z = a1*z + (1-a1)*last_z;
		//last_z = z;

		//はじめのデータ格納
		if (s < N){
			signal_data_for_fft[s] = z;
		}
				
        //FFTデータ数更新
		// else if (s==32||s==64||s==128||s==256||s==512||s==1024||s==2048){
		//  	N = s;
		//  	for (int k=0; k<N; k++){
		//  		signal_data_for_fft[k] = signal_data[k];
		//  	}
		// }

		//データ入れ替え
		else if (s > N){
			for (int k=1; k<N; k++){
				signal_data_for_fft[k-1] = signal_data_for_fft[k];
			}
			signal_data_for_fft[N-1] = signal_data[s];
		}

		//FFT////////////////////////////////////////////////////////
		x = (complex *)malloc(sizeof(complex) * N );
		for (k=0; k<N; k++){
			//ハミング窓をかける
			v_window = 0.54-0.46*cos(2*M_PI*k/(N-1));
			x[k].r = signal_data_for_fft[k]*v_window;
			x[k].i = 0.0;
		}
		
		r = 0;
		i = N>>1;
		
		while(i>0){
			i >>=1;
			r++;
		}
		
		n = 1<<r;
		j2 = n;
		k = 0;
		j1 = r-1;
		
		for (j=0; j<r; j++){
			
			j2>>=1;
			
			for (;;){
				
				for (i=0; i<j2; i++){
					
					p = k>>j1;
					k1 = k + j2;
					
					a = x[k1].r*cos(2.0*M_PI/n*bitr(p,r))
						+x[k1].i*sin(2.0*M_PI/n*bitr(p,r));
					b = x[k1].i*cos(2.0*M_PI/n*bitr(p,r))
						-x[k1].r*sin(2.0*M_PI/n*bitr(p,r));
					
					x[k1].r = x[k].r-a;
					x[k1].i = x[k].i-b;
					x[k].r = x[k].r+a;
					x[k].i = x[k].i+b;
					k++;
					
				}
				
				k += j2;
				if (k>=n) break;   
			}
			k = 0;
			j1--;
		}
		
		for (k=0; k<n; k++){
			bit = bitr(k,r);
			if (bit > k) swap(&x[k],&x[bit]);
		}
		//////////////////////////////////////////////////////////////
		
		//最大の振幅を記録
		k_max = amp_max = 0;
		for (k=0; k<N/2; k++){
			amp[k] = sqrt(pow(x[k].r,2) + pow(x[k].i,2));
			//printf("%lf[Hz]の振幅スペクトル %lf\n",k/(Ts*N),amp[k]);
			if (k != 0 && amp_max < amp[k]){
				k_max = k;
				amp_max = amp[k];
			}
		}
		free(x);

		fprintf(fp,"%d,%lf,%lf\n",s,k_max/(Ts*N),z);
		
		for (k=0;k<500;k++){
			if(k==499){
				fprintf(fp1,"%d,%lf,%lf\n\n",s,k/(Ts*N),amp[k]);
			}else{
				fprintf(fp1,"%d,%lf,%lf\n",s,k/(Ts*N),amp[k]);
			}
		}
	}
	
	fclose(fp);	fclose(fp1);		
	
	return 0;
}
