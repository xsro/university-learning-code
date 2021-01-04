G1=tf(10,[1 0]);
G21=tf(1,[0.05 1]);
G22=tf(1,[0.1 1]);
G2=series(G21,G22);
H=1;

% 1�����㴮��У��װ�õĴ��ݺ��� Gc��s����У�����������
b=1/11;%�ֶ�ϵ��,��ʾ�ͺ����
T=11;%ʱ�䳣��
Gc=tf([b*T 1],[T 1]);
sprintf("У���������a=%g,T=%g",a,T);
display(Gc);

% 2������У����ϵͳ�Ķ�������ͼ�������У����ϵͳ�Ħء�c���͡䡣
G_ori=series(G1,G2);
G_corr=series(Gc,G_ori);

figure(1);
bode(G_ori,G_corr,Gc);grid;
legend('У��ǰ','У����','У������');title('�����ͺ�У��ǰ�󿪻����ݺ�������ͼ');
[Gm_ori,Pm_ori] = margin(G_ori);%Gm: gain margin��ֵԣ�ȣ���λΪһ 
[Gm_corr,Pm_corr] = margin(G_corr);%Pm: phase margin���ԣ��
sprintf("У��ǰ����ֵԣ�ȣ�%g,���ԣ�ȣ�%g",Gm_ori,Pm_ori)
sprintf("У���󣺷�ֵԣ�ȣ�%g,���ԣ�ȣ�%g",Gm_corr,Pm_corr)

% 3���Ƚ�У��ǰ��ϵͳ�Ľ�Ծ��Ӧ���߼�����ָ�꣬˵��У��װ�õ����á�
Phi_ori=feedback(G_ori,H);
Phi_corr=feedback(G_corr,H);
figure(2);
stepplot(Phi_ori,Phi_corr);
legend('У��ǰ','У����');title('�����ͺ�У��ǰ��ջ����ݺ�����Ծ��Ӧ');
info_ori=stepinfo(Phi_ori);
info_corr=stepinfo(Phi_corr);

