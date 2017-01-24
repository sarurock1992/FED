
TOTAL = 1000;

NUM = 20;
Ts  = 0.001;

x = zeros(1,TOTAL);
z = zeros(1,TOTAL);
p = zeros(1,NUM);
q = zeros(1,NUM);
d = zeros(1,NUM);
data = zeros(1,NUM);
sum1 = 0; sum2 = 0; sum3 = 0; check = 0; omega=0;

EF=zeros(1,TOTAL);
plot=zeros(1,TOTAL);

sig  = ((NUM-20)/2+20)*Ts/16;
sig2 = sig*sig;
sig4 = sig2*sig2;

EF(1,1) = 0;
x(1,1)  = 0;

Q = 0.001;
R = 0.01;
    
for i = 2:TOTAL;
x(1,i) = sin(5*pi/500*(i-1));% + Q*(randn);
z(1,i) = x(1,i);% + R*(randn);
end

axis = 1:1:TOTAL;


%hold on
%xlabel('Time')
%ylabel('Position')
%grid on

mu = NUM*Ts/2;

for i = 1:NUM;
p(1,i)=exp(-1*((i-mu)*Ts)^2/(2*sig2));
q(1,i)=(((i-mu)*Ts)^2-sig2)/sig4;
d(1,i)=(i-mu)*Ts/sig2;
end;

%plot(2:TOTAL,p(2:TOTAL));
%hold on;

for k = 2:TOTAL
    l = z(1,k);
    
    if k < NUM+1
        data(1,k) = l;
        
    else i = 2:NUM;
            data(1,i-1)   = data(1,i);
            data(1,NUM-1) = l;
        
            for j = 1:NUM
                sum1 = sum(p(1,j)*q(1,j)*data(1,j));
                sum2 = sum(p(1,j)*data(1,j));
                sum3 = sum(d(1,j)*data(1,j));
                
                check = -1*sum1/sum2;
                
                if check > 0    
                    omega = realsqrt(check);
                    EF(1,j) = omega;
                end
                
            end
            
    end
    
end

x = 0:pi/100:2*pi;
y = sin(x);

figure % opens new figure window
plot(x,y)


%plot(2:TOTAL,EF(2:TOTAL))
%hold on
%title('Extended Kalman Filtering of a Sine Wave - Frequency');
%legend([b r],'True Frequency','Frequency Estimates');
%xlabel('Time')
%ylabel('Frequency')