function jury(input)
%myFun - Description
%
% Syntax: jury(input)
%
% Long description
disp('���������о��ж���ɢϵͳ���ȶ���')
disp('�������������̵�ϵ������A')
A=input;
n=size(A,2);%��ȡA��ά��
for i=n:-1:1
    disp(A);%��ʾ������
    if i==1 
        if A(:)>0
            disp('ϵͳ�ȶ�');
        else
            disp('ϵͳ���ȶ�');
        end
        break;
    end
    B=flip(A);
    disp(B);%��ʾż����
    if A(1,1)<=0
        disp('��Ԫ�ط�����ϵͳ���ȶ�');
        break;
    end
    k=B(1,1)/A(1,1);
    A(1,:)=A(1,:)-k*B(1,:);
    A(:,i)=[];%A�����ά��
end
% ��������������������������������
% ��Ȩ����������ΪCSDN�����������Թ�ѧԪ������ԭ�����£���ѭCC 4.0 BY-SA��ȨЭ�飬ת���븽��ԭ�ĳ������Ӽ���������
% ԭ�����ӣ�https://blog.csdn.net/weixin_44044411/article/details/86475605
end