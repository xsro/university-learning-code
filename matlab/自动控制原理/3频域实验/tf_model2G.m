function output=tf_model2G(inCon,outCon,Go)
%����������ݿ�����������ϵͳ�Ĵ��ݺ���������ض���Ĵ��ݺ���
pid_in=pid(inCon(1),inCon(2),inCon(3),0);%0.8+0.02*s% �ڻ�������;
pid_out=pid(outCon(1),outCon(2),outCon(3),0);%4;% �⻷������;
s=tf('s');
output=Go/(pid_out*pid_in-Go*pid_in*s-pid_out*pid_in*Go);
output=minreal(output);
end
