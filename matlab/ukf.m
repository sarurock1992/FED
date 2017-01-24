function[xhat_new, P_new, G] = ukf(f,h,B,Q,R,y,xhat,P)
xhat = xhat(:);
y=y(:);

[xhatm, Pm] = ut(f, xhat, P);
Pm          = Pm + B*Q*B';
[yhatm, Pyy, Pxy] = ut(h, xhatm, Pm);

G =Pxy/(Pyy+R);
xhat_new = xhatm + G*(y-yhatm);
P_new = Pm - G*Pxy';
end
