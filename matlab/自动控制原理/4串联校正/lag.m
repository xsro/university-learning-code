G1=tf(10,[1 0]);
G21=tf(1,[0.05 1]);
G22=tf(1,[0.1 1]);
G2=series(G21,G22);
H=1;

% 1．计算串联校正装置的传递函数 Gc（s）和校正网络参数。
b=1/11;%分度系数,表示滞后深度
T=11;%时间常数
Gc=tf([b*T 1],[T 1]);
sprintf("校正网络参数a=%g,T=%g",a,T);
display(Gc);

% 2．画出校正后系统的对数坐标图，并求出校正后系统的ω′c及ν′。
G_ori=series(G1,G2);
G_corr=series(Gc,G_ori);

figure(1);
bode(G_ori,G_corr,Gc);grid;
legend('校正前','校正后','校正环节');title('串联滞后校正前后开环传递函数伯德图');
[Gm_ori,Pm_ori] = margin(G_ori);%Gm: gain margin幅值裕度，单位为一 
[Gm_corr,Pm_corr] = margin(G_corr);%Pm: phase margin相角裕度
sprintf("校正前：幅值裕度：%g,相角裕度：%g",Gm_ori,Pm_ori)
sprintf("校正后：幅值裕度：%g,相角裕度：%g",Gm_corr,Pm_corr)

% 3．比较校正前后系统的阶跃响应曲线及性能指标，说明校正装置的作用。
Phi_ori=feedback(G_ori,H);
Phi_corr=feedback(G_corr,H);
figure(2);
stepplot(Phi_ori,Phi_corr);
legend('校正前','校正后');title('串联滞后校正前后闭环传递函数阶跃响应');
info_ori=stepinfo(Phi_ori);
info_corr=stepinfo(Phi_corr);

