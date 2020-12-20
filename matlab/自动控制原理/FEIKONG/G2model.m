function output=G2model(Gi,outCon,inCon)
%根据内环外环控制器和被控系统的传递函数给出总体的传递函数
s=tf('s');
pid_in=pid(inCon(1),inCon(2),inCon(3));% 内环控制器;
pid_out=pid(outCon(1),outCon(2),outCon(3));% 外环控制器;
G1=series(pid_in,Gi);
G2=feedback(G1,s);
G3=series(pid_out,G2);
G4=feedback(G3,1);
output=minreal(G4);
end