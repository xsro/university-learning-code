G1=tf(10,[1 0]);
G2=tf(2,[0.2 1]);
H=1;

% 1�����㴮��У��װ�õĴ��ݺ��� Gc��s����У�����������
a=11;%�ֶ�ϵ��
T=0.005;%ʱ�䳣��
Gc=tf([a*T 1],[T a]);
% Gc1=tf(1,2);
% Gc2=tf(2*[0.055 1],[0.005 1]);
% Gc00=series(Gc1,Gc2);
sprintf("У���������a=%g,T=%g",a,T);
display(Gc);

% 2������У����ϵͳ�Ķ�������ͼ�������У����ϵͳ�Ħء�c���͡䡣
G_ori=series(G1,G2);
G_corr=series(Gc,G_ori);

figure(1);
bode(G_ori,G_corr,Gc);grid;
legend('У��ǰ','У����','У������');title('У��ǰ�󿪻����ݺ�������ͼ');
[Gm_ori,Pm_ori] = margin(G_ori);%Gm: gain margin��ֵԣ�ȣ���λΪһ 
[Gm_corr,Pm_corr] = margin(G_corr);%Pm: phase margin���ԣ��
info1=sprintf("У��ǰ����ֵԣ�ȣ�%g,���ԣ�ȣ�%g",Gm_ori,Pm_ori);
info2=sprintf("У���󣺷�ֵԣ�ȣ�%g,���ԣ�ȣ�%g",Gm_corr,Pm_corr);
display([info1,info2]);

% 3���Ƚ�У��ǰ��ϵͳ�Ľ�Ծ��Ӧ���߼�����ָ�꣬˵��У��װ�õ����á�
Phi_ori=feedback(G_ori,H);
Phi_corr=feedback(G_corr,H);
figure(2);
stepplot(Phi_ori,Phi_corr);
legend('У��ǰ','У����');title('������ǰУ��ǰ��ջ����ݺ�����Ծ��Ӧ');
info_ori=stepinfo(Phi_ori);
info_corr=stepinfo(Phi_corr);

