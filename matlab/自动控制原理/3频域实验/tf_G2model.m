function output=tf_G2model(outCon,inCon,Gi)
%根据内环外环控制器和被控系统的传递函数给出总体的传递函数
s=tf('s');
pid_in=inCon(1)+inCon(2)/s+inCon(3)*s;% 内环控制器;
pid_out=outCon(1)+outCon(2)/s+outCon(3)*s;% 外环控制器;
GH=feedback(pid_in*Gi,s);
output=feedback(pid_out*GH,1);
output=minreal(output);
shoo=pid_out*pid_in*Gi/(1+pid_in*Gi*s+pid_out*pid_in*Gi);
tf2zp(shoo)
tf2zp(output)
end