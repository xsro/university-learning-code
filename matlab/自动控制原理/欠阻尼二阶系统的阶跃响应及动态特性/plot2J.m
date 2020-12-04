Xi=0:0.01:1;
Xi=Xi';
Omega_n=ones(size(Xi));
T=twoJ(Xi,Omega_n);
% data= [t_r,t_p,SigmaPercent,t_s1,t_s2];
hold on
subplot(2,3,1);
plot(Xi,T.t_r);
title("上升时间");
subplot(2,3,2);
plot(Xi,T.t_p);
title("峰值时间");

subplot(2,3,4);
plot(Xi,T.SigmaPercent);
title("超调量")
subplot(2,3,5);
plot(Xi,T.t_s1);
title("调节时间1 0.05误差带");
subplot(2,3,6);
plot(Xi,T.t_s2);
title("调节时间2 0.02误差带");