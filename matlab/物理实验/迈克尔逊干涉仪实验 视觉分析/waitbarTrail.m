% ��ʼ���������������ؾ��
% e = lim(1+1/x)^x (x -> ��)
f = waitbar(0,'1','Name','���޷�����Ȼ����eֵ');
num=1000;
% ���ý�����������ɫ
set(f,'color','w');
% ����x�����ȡֵ
x = 2000;
% ��ѭ���м������������ʾ�������״̬
for k = 1:num
    % Update waitbar and message
    ek = (1+1/k)^k;
    string=sprintf('%s %12.9f %s','��ǰeֵ: ',ek,['����ɣ�',num2str(round(100*k/num)),'%']);
    display(string);clc;
    waitbar(k/num,f,string);
end