%绘制机械特性的matlab
name=["固有机械特性","串电阻人为机械特性","弱磁人为机械特性"];
N=3;
for i=1:N
    num=xlsread('data.xlsx',i);
    n=num(2,:);
    T=num(4,:);
    p=polyfit(T,n,1);
    f=polyval(p,T);
    figure(i)
    plot(T,n,'x',T,f,'r-');
    legend("实测值","拟合曲线");
    str=sprintf(' n= %g T +%g ',p(1),p(2));
    title(strcat(name(i),str));
    xlabel('T');
    ylabel('n');
    figure(4);
    T2=[0,T,-p(2)/p(1)];
    n2=polyval(p,T2);
    plot(T2,n2,'DisplayName',name(i));
    hold on;
end
figure(4);
title("固有机械特性 人为机械特性比较");
grid
    xlabel('T');
    ylabel('n');
legend
hold off
