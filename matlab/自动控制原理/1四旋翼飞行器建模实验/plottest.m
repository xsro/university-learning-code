% 系统辨识
load onedata
nx=4;
N=length(y)-nx;
u=[zeros(nx,1);ones(N,1)];
data2=iddata(y,u,0.05);
figure();
subplot(1,2,1)
plot(data2);
title('采样数据')
idsys=tfest(data2,3,0);
subplot(1,2,2)
stepplot(idsys,'k-');
hold on
plot(x,y);
title('系统辨识之后')
