Xi=0:0.01:1;
Xi=Xi';
Omega_n=ones(size(Xi));
T=twoJ(Xi,Omega_n);
% data= [t_r,t_p,SigmaPercent,t_s1,t_s2];
hold on
subplot(2,3,1);
plot(Xi,T.t_r);
title("����ʱ��");
subplot(2,3,2);
plot(Xi,T.t_p);
title("��ֵʱ��");

subplot(2,3,4);
plot(Xi,T.SigmaPercent);
title("������")
subplot(2,3,5);
plot(Xi,T.t_s1);
title("����ʱ��1 0.05����");
subplot(2,3,6);
plot(Xi,T.t_s2);
title("����ʱ��2 0.02����");