function output=tf_G2model(outCon,inCon,Gi)
%�����ڻ��⻷�������ͱ���ϵͳ�Ĵ��ݺ�����������Ĵ��ݺ���
s=tf('s');
pid_in=inCon(1)+inCon(2)/s+inCon(3)*s;% �ڻ�������;
pid_out=outCon(1)+outCon(2)/s+outCon(3)*s;% �⻷������;
GH=feedback(pid_in*Gi,s);
output=feedback(pid_out*GH,1);
output=minreal(output);
shoo=pid_out*pid_in*Gi/(1+pid_in*Gi*s+pid_out*pid_in*Gi);
tf2zp(shoo)
tf2zp(output)
end