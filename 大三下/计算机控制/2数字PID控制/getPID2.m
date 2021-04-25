%等幅振荡时的数据
Tk=0.755906;
Kk=10.85;

%查表在控制度为1.05时的数据
T_Tk=0.014;
Kp_Kk=0.63;
TI_Tk=0.49;
TD_Tk=0.14;

%计算对应参数
T=T_Tk*Tk;
Kp=Kp_Kk*Kk;
TI=TI_Tk*Tk;
TD=TD_Tk*Tk;

%计算pid传递函数
pidsys=pid(Kp,Kp/TI,Kp*TD,0,T);
pidstd=pidstd(Kp,TI,TD,Inf,T);
display(pidsys);