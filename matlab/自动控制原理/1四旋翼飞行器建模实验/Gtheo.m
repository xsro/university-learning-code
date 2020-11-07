%根据指导书中给定的程序来获得数字仿真的传递函数模型
%inCon为内环PID控制参数
%outCon为外环PID控制参数
function G1=Gtheo(inCon,outCon)
s=tf('s');
C=0.8+0.02*s;
A=2351;
B=s*s*s+17.93*s*s+382.2*s+2013;
G=A/(C*(4*B-4*A-s*A));

ctrlrate=pid(inCon(1),inCon(2),inCon(3),0);%0.8+0.02*s;% 内环控制器;
GH=feedback(ctrlrate*G,s);
ctrlangle=pid(outCon(1),outCon(2),outCon(3),0);%4;% 外环控制器;
G1=feedback(ctrlangle*GH,1);