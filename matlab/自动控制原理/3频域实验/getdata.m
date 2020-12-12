function [Omega,A,P]=getdata(sheet)  
    num=xlsread('data.xlsx',sheet);
    %A代表幅值比这里单位由dB转化为1，P代表相位差，F代表频率
    %表中数据的顺序为 频率、幅值比、相位差
    Omega=num(:,1);
    F=Omega./pi;%转化为频率
    A=num(:,2);
    A=10.^(A./20);
    P=num(:,3);
    T=table(F,Omega,A,P);
    filename=strcat('res.xlsx');
    writetable(T,filename,'Sheet',sheet);
end
