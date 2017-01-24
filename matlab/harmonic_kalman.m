clear

%%プラントモデルを用いた入出力データの作成
%物理パラメータの設定
 c = 0;
 m = 1;
 k = 1;

%離散化周期
 dT = 0.01;

%入力の設定
 N = 2000;
 t = (dT*(0:(N-1)))';
 u = @(t) 0
 %u = @(t) 4*sawtooth(t*sqrt(2))+10*sin(t);

%観測雑音
 R = 0.1;

%連続時間モデル
 dxdt = @(t,x) [x(2); -x(3)*x(2)/m-k*x(1)/m; 0] + [0; 1/m; 0]*u(t);
 h    = @(x) x(1);

%ルンゲクッタ法で離散時間状態遷移写像fを計算
 f = c2d_rk4(dxdt,dT);

%出力の計算
%記憶領域の確保
 x  = zeros(N,3);
 y0 = zeros(N,1);

%状態初期値
x(1,:) = [1; 1; c];
y0(1)  = h(x(1,:));

%時間更新
for n = 2:N
x(n,:) = f((n-1)*dT, x(n-1,:)');
y0(n,:)  = h(x(n,:));
end

w =0
%w = randn(N,1)*sqrtm(R);
y = y0 + w;

%%UKFによる同時推定
%仮想的なシステム雑音の共分散
Q = diag([1e-5, 1e-5, 1e-5]);

%推定値記憶領域の確保
xhat = zeros(N,3);
yhat = zeros(N,1);

%初期値
xhat(1,:) = [0; 0; 0.1*c];
yhat(1,:) = h(xhat(1,:));
P =diag([10, 10, 10]);

%時間更新
for n = 2:N
[xhat(n,:), P] = ukf(@(x) f((n-1)*dT,x),h,1,Q,R,y(n,:),xhat(n-1,:),P);
yhat(n,:) = h(xhat(n,:));

end

%%結果の出力
figure(1), clf
	ylabels = {'Position', 'Velocity', 'Parameter c'};
    
for p = 1:3

subplot(3,1,p);
plot(t, x(:,p), 'r', t, xhat(:,p), 'b');
xlim([min(t) max(t)]);
ylabel(ylabels{p});
xlabel('Times[s]')
legend('ture', 'estimated','Location', 'SouthEast')

end
