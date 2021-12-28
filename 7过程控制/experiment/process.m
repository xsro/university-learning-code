%实验一：单回路控制系统的参数整定

%选取一阶惯性环节加滞后环节建模
%通过实验测试法获取传递函数参数
tau=35;
T=37;
K=0.64;
s=tf('s');
W=exp(-s*tau)*K/(T*s+1);

C=["开环","P","PI","PD","PID"];
% spec="k"+["-","-.","--","--",":"];
figure()
hold on

t=1:600;
%开环控制
stepplot(W,t);
title("过程对象控制效果仿真");

%pid反馈控制
for i=2:5
    Gc=pidtune(W,C(i));
    Phi=feedback(series(Gc,W),1);
    stepplot(Phi,t);
end
legend(C+"控制")
grid

%save figure
saveas(gcf,'__process.png','png');


