function [Omega,A,P]=getdata(sheet)  
    num=xlsread('data.xlsx',sheet);
    %A�����ֵ�����ﵥλ��dBת��Ϊ1��P������λ�F����Ƶ��
    %�������ݵ�˳��Ϊ Ƶ�ʡ���ֵ�ȡ���λ��
    Omega=num(:,1);
    F=Omega./pi;%ת��ΪƵ��
    A=num(:,2);
    A=10.^(A./20);
    P=num(:,3);
    T=table(F,Omega,A,P);
    filename=strcat('res.xlsx');
    writetable(T,filename,'Sheet',sheet);
end
