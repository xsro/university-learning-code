%ʹ��Matlab�Դ����߽���PIDϵ��������
Ts=0.01;
Tf=0;
Gp1=tf(5,conv([0.5 1],[0.1 1]));
Gp1d=c2d(Gp1,Ts,'zoh');
%PIDϵ������
C1 = pidtune(Gp1d,'PID');

Gp2=tf(1,conv([1 0],[0.1 1]));
Gp2d=c2d(Gp2,Ts,'zoh');
%PIDϵ������
C2 = pidtune(Gp2d,'PID');