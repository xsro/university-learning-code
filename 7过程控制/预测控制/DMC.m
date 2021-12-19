% from: https://blog.csdn.net/hlld__/article/details/106677811
% title: ��̬������ƣ�DMC���ļ���⼰��ʾ��
clc,close,clear;

% ���ض��󴫵ݺ���
num=[1 5];
den=[1 5 3];
g=tf(num,den);

steps=100; % ���沽��
ts=1; % ��������
p=10; % Ԥ�ⲽ��
m=1; % ���Ʋ���
n=20; % �ضϲ���

% ��ɢ״̬�ռ䷽��
[as,bs,cs,ds]=tf2ss(num,den);
[ad,bd]=c2d(as,bs,ts);
xs0=[0 0]';

% ���ݺ�����Ծ��Ӧ
[a0,t]=step(g,0:ts:(n-1)*ts);

% ���춯̬����
a=zeros(p,m);
a(:,1)=a0(1:p);
for i=1:p
    for j=2:m
        if i>=j
            a(i,j)=a(i-1,j-1);
        end
    end
end

% ���߼������Ž�ϵ��d
q=eye(p);
r=0*eye(m);
c=zeros(m,1);
c(1)=1;
d=(a'*q*a+r)^-1*a'*q;
d=c'*d;

% ��������Ȩ������ת�ƾ���
h=0.5*ones(n,1);
h(1)=1;
s=zeros(n,n);
for i=1:n-1
    s(i,i+1)=1;
end
s(n,n)=1;

yr=ones(p,1); % �ο��켣
y0=zeros(n,1); % ģ��Ԥ��
y=zeros(steps,1); % ʵ�����
u=zeros(steps,1); % ϵͳ������

% �ײ�����
xs1=ad*xs0;
y(1)=cs*xs1;
xs0=xs1;
ycor=y0+h*(y(1)-y0(1));
y0=s*ycor;
du=d*(yr-y0(1:p));
y0=y0+a0*du;
u(1)=du;

% �����Ż�
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

% ����ͼ��
figure(1);
subplot(211);
plot(y,'linewidth',2);
title('ϵͳ���');
xlabel('t');
ylabel('y');
ylim([0 1.2])
grid on;
subplot(212);
plot(u,'linewidth',2);
title('��������');
xlabel('t');
ylabel('u');
grid on;
