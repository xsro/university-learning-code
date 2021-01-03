%读取数据
num=xlsread('data.xlsx');
X1=num(1,:);
Y1=num(2,:);

%线性拟合并绘图
x=X1;
y=Y1;
p=polyfit(x,y,1);
f = polyval(p,x); 
plot(x,y,'o-',x,f,'r-') ;
xlabel('温度T/℃');
ylabel('电压V/mV');
title('热电偶测温性能试验数据曲线与最小二乘法拟合曲线');
legend('实验数据','最小二乘法拟合');
%估算180摄氏度时的电压值
polyval(p,180)