% from: https://blog.csdn.net/hlld__/article/details/106677811
% title: 动态矩阵控制（DMC）的简单理解及其示例
clc,close,clear;

% 被控对象传递函数
num=[1 5];
den=[1 5 3];
g=tf(num,den);

steps=100; % 仿真步数
ts=1; % 采样周期
p=10; % 预测步长
m=1; % 控制步长
n=20; % 截断步长

% 离散状态空间方程
[as,bs,cs,ds]=tf2ss(num,den);
[ad,bd]=c2d(as,bs,ts);
xs0=[0 0]';

% 传递函数阶跃响应
[a0,t]=step(g,0:ts:(n-1)*ts);

% 构造动态矩阵
a=zeros(p,m);
a(:,1)=a0(1:p);
for i=1:p
    for j=2:m
        if i>=j
            a(i,j)=a(i-1,j-1);
        end
    end
end

% 离线计算最优解系数d
q=eye(p);
r=0*eye(m);
c=zeros(m,1);
c(1)=1;
d=(a'*q*a+r)^-1*a'*q;
d=c'*d;

% 构造误差加权向量及转移矩阵
h=0.5*ones(n,1);
h(1)=1;
s=zeros(n,n);
for i=1:n-1
    s(i,i+1)=1;
end
s(n,n)=1;

yr=ones(p,1); % 参考轨迹
y0=zeros(n,1); % 模型预测
y=zeros(steps,1); % 实际输出
u=zeros(steps,1); % 系统控制量

% 首步计算
xs1=ad*xs0;
y(1)=cs*xs1;
xs0=xs1;
ycor=y0+h*(y(1)-y0(1));
y0=s*ycor;
du=d*(yr-y0(1:p));
y0=y0+a0*du;
u(1)=du;

% 滚动优化
for k=2:steps
    xs1=ad*xs0+bd*u(k-1);
    y(k)=cs*xs1+ds*u(k-1);
    xs0=xs1;
    ycor=y0+h*(y(k)-y0(1));
    y0=s*ycor;
    du=d*(yr-y0(1:p));
    y0=y0+a0*du;
    u(k)=u(k-1)+du;
end

% 绘制图形
figure(1);
subplot(211);
plot(y,'linewidth',2);
title('系统输出');
xlabel('t');
ylabel('y');
ylim([0 1.2])
grid on;
subplot(212);
plot(u,'linewidth',2);
title('控制输入');
xlabel('t');
ylabel('u');
grid on;
