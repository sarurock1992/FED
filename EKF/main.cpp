#include <iostream>
#include <Eigen/Dense>

#define N 1000

using namespace Eigen;
using namespace std;

int main(int argc, char *argv[]){

	MatrixXd W(2,2);
	W<<1,0,0,0;

	MatrixXd H(2,2);
	H<<1,0,0,1;

	MatrixXd V(2,2);
	V<<1,0,0,1;

	MatrixXd I(2,2);
	I<<1,0,0,1;

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

	Eigen::MatrixXd *Ai;
  Ai = new Eigen::MatrixXd [N];

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
	Ai[i] = Eigen::MatrixXd::Identity(2,2);
	Ai[i] << 0,0,0,0;
  }

	x[0] << 0,0.25;
	x_hat[0] << 0,0;

	MatrixXd Q(2,2);
	Q<<0.001,0,0,0;

	MatrixXd R(2,2);
	R<<0.1,0,0,0.01;

	P_hat[0] << 1,0,0,1;

for(int i=1; i<N; i++){
	x[i]       << sin(x[i-1](1,0)*i), i;
	z[i]       = x[i];
	x_pre[i]   << sin(x_hat[i-1](1,0)*i), x_hat[i-1](1,0);
	Ai[i]      << 0,i*cos(x_hat[i-1](1,0)*i),0,1;
	P_pre[i]   = Ai[i]*P_hat[i-1]*Ai[i].transpose() + W*Q*W.transpose();
	K[i](0,0)  = P_pre[i](0,0)*H.transpose()(0,0) / (H(0,0)*P_pre[i](0,0)*H.transpose()(0,0) + V(0,0)*R(0,0)*V.transpose()(0,0));
	K[i](0,1)  = P_pre[i](0,1)*H.transpose()(0,1) / (H(0,1)*P_pre[i](0,1)*H.transpose()(0,1) + V(0,1)*R(0,1)*V.transpose()(0,1));
	K[i](1,0)  = P_pre[i](1,0)*H.transpose()(1,0) / (H(1,0)*P_pre[i](1,0)*H.transpose()(1,0) + V(1,0)*R(1,0)*V.transpose()(1,0));
	K[i](1,1)  = P_pre[i](1,1)*H.transpose()(1,1) / (H(1,1)*P_pre[i](1,1)*H.transpose()(1,1) + V(1,1)*R(1,1)*V.transpose()(1,1));
	//K[i]       = P_pre[i]*H.transpose() + (H*P_pre[i]*H.transpose() + V*R*V.transpose());
	x_hat[i]   = x_pre[i] + K[i]*(z[i] - x_pre[i]);
	P_hat[i]   = (I - K[i]*H)*P_pre[i];
	cout << x[i](1,0) << ":" << x[i](0,0) << endl;
	cout << x_hat[i](1,0) << ":" << x_hat[i](0,0) << endl;
 }
 cout << x[0] << endl;
 return 0;
}
