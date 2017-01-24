#include <iostream>
#include <Eigen/Core>

#define N 1000

using namespace std;

int main(int argc, char *argv[]){

	Eigen::MatrixXd *W;
	W<<1,0,0,0;

	Eigen::MatrixXd *H;
	H<<1,0,0,1;

	Eigen::MatrixXd *W;
	V<<1,0,0,1;

  Eigen::MatrixXd *x;
  x = new Eigen::MatrixXd [N];

	Eigen::MatrixXd *x_pre;
  x_pre = new Eigen::MatrixXd [N];

	Eigen::MatrixXd *x_hat;
  x_hat = new Eigen::MatrixXd [N];

	Eigen::MatrixXd *P_pre;
  P_pre = new Eigen::MatrixXd [N];

	Eigen::MatrixXd *P_hat;
  P_hat = new Eigen::MatrixXd [N];

	Eigen::MatrixXd *z;
  z = new Eigen::MatrixXd [N];

	Eigen::MatrixXd *K;
  K = new Eigen::MatrixXd [N];

  for(int i=0; i<N; i++){
	x[i] = Eigen::MatrixXd::Identity(2,1);
	x[i] << 0,0;
	x_pre[i] = Eigen::MatrixXd::Identity(2,1);
	x_pre[i] << 0,0;
	x_hat[i] = Eigen::MatrixXd::Identity(2,1);
	x_hat[i] << 0,0;
	P_pre[i] = Eigen::MatrixXd::Identity(2,2);
	P_pre[i] << 0,0,0,0;
	P_hat[i] = Eigen::MatrixXd::Identity(2,2);
	P_hat[i] << 0,0,0,0;	
	z[i] = Eigen::MatrixXd::Identity(2,1);
	z[i] << 0,0;
	K[i] = Eigen::MatrixXd::Identity(2,2);
	K[i] << 0,0,0,0;
  }

	x[0] << 0,3*3.14/500;
	x_hat[0] << 1,1*3.14/500;

	Eigen::MatrixXd *Q;
	Q<<0.001,0,0,0;

	Eigen::MatrixXd *R;
	R<<0.001,0,0,0;

	P_hat[0] << 1,0,0,1;

for(int i=1; i<N; i++){
	x[i]       << sin(x[i-1](1,0)*i), x[i-1](1,0);
	z[i]       << x[i]
	x_pre[i]   << sin(x_hat[i-1](1,0),i), x_hat[i-1](1,0);
	Ai[i]      << 0,i*cos(x_hat[i-1](1,0)*i),0,1;

	P_pre[i]   << Ai*P_hat[i-1]*Ai.taranspose() + W*Q*W.taranspose();
	K[i]       << P_pre[i]*H.taranspose() / (H*P_pre[i]*H.taranspose() + V*R*V.transpose());
	x_hat[i]   << x_pre[i] + K[i]*(z[i] - x_pre[i]);
	P_hat[i]   << (I - k[i]*H)*P_pre[i];
 }

 return 0
}





		
	
