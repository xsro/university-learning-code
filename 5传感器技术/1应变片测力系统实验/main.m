%读取数据
num=xlsread('data.xlsx');
W=num(1,:);
Uup=num(2,:);
Udown=num(3,:);
U=mean([Uup;Udown]);

%线性拟合并绘图
x=[W,fliplr(W)];
y=[Uup,fliplr(Udown)];
p=polyfit(x,y,1);
f = polyval(p,x); 
plot(x,y,'o-',x,f,'-') 
xlabel('重量W/g');
ylabel('输出电压V/mV');
title('应变片测力系统试验曲线与最小二乘法拟合曲线');
legend('实验数据','最小二乘法拟合','location','southeast');

%计算灵敏度S：S=ΔV/ΔW(ΔV为输出电压平均变化量；ΔW重量变化量)，
S=(max(U)-min(U))./(max(W)-min(W));

% 计算非线性误差：δf1=Δm/yF·S×100%，
% 式中Δm为输出电压值(多次测量时为平均值)与拟合直线的最大电压偏差量：
% yF·S为满量程时电压输出平均值。（用最小二乘法进行直线拟合）
e=abs(U-polyval(p,W));
el=max(e)./max(U);

sprintf('灵敏度%g 非线性误差%g',S,el);
%输出结果
% T=table(S,el,'VariableNames',{'灵敏度','非线性误差'});
% display(T);