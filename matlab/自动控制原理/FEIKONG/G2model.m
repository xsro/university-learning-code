function output=G2model(Gi,outCon,inCon)
%�����ڻ��⻷�������ͱ���ϵͳ�Ĵ��ݺ�����������Ĵ��ݺ���
s=tf('s');
pid_in=pid(inCon(1),inCon(2),inCon(3));% �ڻ�������;
pid_out=pid(outCon(1),outCon(2),outCon(3));% �⻷������;
G1=series(pid_in,Gi);
G2=feedback(G1,s);
G3=series(pid_out,G2);
G4=feedback(G3,1);
output=minreal(G4);
end