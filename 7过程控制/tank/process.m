%实验中采用测试法对系统进行建模
tau=35;
T=37;
K=0.64;
s=tf('s');
W=exp(-s*tau)*K/(T*s+1);

C=["开环","P","PI","PID"];
spec="k"+["-","--",":","-."];
figure()
hold on

stepplot(W,spec(1));
title("过程对象控制效果仿真");

for i=2:4
    Gc=pidtune(W,C(i));
    Phi=feedback(series(Gc,W),1);
    stepplot(Phi,spec(i));
end
legend(C+"控制")
grid

%save figure into .fig format
saveas(gcf,'__process.png','png');


