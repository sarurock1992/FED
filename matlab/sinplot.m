%Ts=1ms

Ts=0:0.001:0.001*1000;
y=sin(20*pi*Ts);

yd=round(y,6)

%plot(Ts,y);
plot(Ts,y,Ts,yd,'r*');



%save('sin.mat','y','Ts');

%yd = c2d(y,Ts,'zoh');

%step(y,'-',yd,'--')