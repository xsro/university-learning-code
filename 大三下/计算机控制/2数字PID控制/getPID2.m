%�ȷ���ʱ������
Tk=0.755906;
Kk=10.85;

%����ڿ��ƶ�Ϊ1.05ʱ������
T_Tk=0.014;
Kp_Kk=0.63;
TI_Tk=0.49;
TD_Tk=0.14;

%�����Ӧ����
T=T_Tk*Tk;
Kp=Kp_Kk*Kk;
TI=TI_Tk*Tk;
TD=TD_Tk*Tk;

%����pid���ݺ���
pidsys2=pid(Kp,Kp/TI,Kp*TD,0,T);
pidstd2=pidstd(Kp,TI,TD,Inf,T);
display(pidsys2);