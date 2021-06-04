function T= twoJ(Xi,Omega_n)
    %�������ϵͳ��һЩ����
    Omega_d=sqrt(1-Xi.^2).*Omega_n;
    Sigma=Xi.*Omega_n;
    Beta=atan(Xi);
    %����ʱ��
    t_r=(pi-Beta)./Omega_d;
    %��ֵʱ��
    t_p=pi./Omega_d;
    %������
    SigmaPercent=exp(-pi.*Xi./sqrt(1-Xi.^2));
    %����ʱ��0.05����
    t_s1=3.5./Sigma;
    %����ʱ��0.02����
    t_s2=4.4./Sigma;
    T=table(t_r,t_p,SigmaPercent,t_s1,t_s2);
end