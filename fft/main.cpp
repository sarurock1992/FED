#include "fft.h"

int main(void){

	int SIZE,N,j;
	double Ts,frequency_by_fft;
	FILE *fp,*fd;
	char buff[1500];

	//omega = 2*M_PI;
	Ts = 0.001;//[s]
	SIZE = 10000;

	double signal_data[SIZE],signal_data_for_fft[SIZE];

	fd=fopen("../accdata/o05pi_3pi_02pi_n_1000hz.csv","r");
	//fd=fopen("../accdata/brain02.csv","r");
	//fd=fopen("../accdata/o3pi_n_1000hz.csv","r");

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


	N = 16;
	
	for (int i=0; i<SIZE; i++){
		if (i%100==0){
			cout << "i = " << i << endl;
		}

		if (i < N){
			signal_data_for_fft[i] = signal_data[i];
		}
				
		else if (i==32||i==64||i==128||i==256||i==512||i==1024||i==2048){
			N = i;
			for (int k=0; k<N; k++){
				signal_data_for_fft[k] = signal_data[k];
			}
		}
		
		else if (i > N){
			for (int k=1; k<N; k++){
				signal_data_for_fft[k-1] = signal_data_for_fft[k];
			}
			signal_data_for_fft[N-1] = signal_data[i];
		}
		// cout << fft(N, signal_data, Ts);
		frequency_by_fft = fft(N,signal_data_for_fft,Ts);

		// for (int j=0; j<N; j++){
		// 	printf("N = %d fft[%d]= %lf\n",N,j,signal_data_for_fft[j]);
		// }

		fprintf(fp,"%d,%lf,%lf\n",i,frequency_by_fft,signal_data[i]);
	}
	fclose(fp);	

	return 0;
}
