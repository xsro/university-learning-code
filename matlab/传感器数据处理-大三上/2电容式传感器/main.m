%读取数据
num=xlsread('data.xlsx');
X1=num(1,:);
Y1=num(2,:);
X2=num(3,:);
Y2=num(4,:);
X2=X2(~isnan(X2));
Y2=Y2(~isnan(Y2));

%线性拟合并绘图
x=[fliplr(X2),X1];
y=[fliplr(Y2),Y1];
p=polyfit(x,y,1);
f = polyval(p,x); 
plot(x,y,'o-',x,f,'r-') ;
xlabel('梁端位移X/mm');
ylabel('电压V/mV');
title('电容式传感器位移实验曲线和最小二乘法拟合曲线');
legend('实验曲线','最小二乘法拟合曲线');
grid

%计算系统灵敏度Ｓ。Ｓ＝ΔＶ／ΔＸ（式中ΔＶ为电压变化，ΔＸ为相应的梁端位移变化）。
S=(max(y)-min(y))./(max(x)-min(x));

% 计算非线性误差：δf1=Δm/yF·S×100%，
e=abs(x-polyval(p,x));
el=max(e)./max(y);

%输出结果
sprintf('灵敏度%g非线性误差%g',S,el);
% T=table(S,el,'VariableNames',{'灵敏度','非线性误差'});
% display(T);