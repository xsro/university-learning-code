%����ָ�����и����ĳ�����������ַ���Ĵ��ݺ���ģ��
%inConΪ�ڻ�PID���Ʋ���
%outConΪ�⻷PID���Ʋ���
function G1=Gtheo(inCon,outCon)
s=tf('s');
C=0.8+0.02*s;
A=2351;
B=s*s*s+17.93*s*s+382.2*s+2013;
G=A/(C*(4*B-4*A-s*A));

ctrlrate=pid(inCon(1),inCon(2),inCon(3),0);%0.8+0.02*s;% �ڻ�������;
GH=feedback(ctrlrate*G,s);
ctrlangle=pid(outCon(1),outCon(2),outCon(3),0);%4;% �⻷������;
G1=feedback(ctrlangle*GH,1);