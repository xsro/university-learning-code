function T= twoJ(Xi,Omega_n)
    %计算二阶系统的一些参数
    Omega_d=sqrt(1-Xi.^2).*Omega_n;
    Sigma=Xi.*Omega_n;
    Beta=atan(Xi);
    %上升时间
    t_r=(pi-Beta)./Omega_d;
    %峰值时间
    t_p=pi./Omega_d;
    %超调量
    SigmaPercent=exp(-pi.*Xi./sqrt(1-Xi.^2));
    %调节时间0.05误差带
    t_s1=3.5./Sigma;
    %调节时间0.02误差带
    t_s2=4.4./Sigma;
    T=table(t_r,t_p,SigmaPercent,t_s1,t_s2);
end