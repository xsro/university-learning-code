np=[3 2];
nz=[0 1];
tit={'俯仰通道实验','偏航通道实验'};
[~,sheets] = xlsfinfo('data.xlsx');
N=2;
for i=1:N
    [F,A,P]=getdata(i);
    h=A.*exp(1i*P/180*pi);
    data=idfrd(h,F,0);
    model=tfest(data,np(i),nz(i));
    display(model)
    figure(1);
    subplot(1,2,i)
    bode(data,'rx-',model);
    legend('实测值','系统识别值');
    title(tit(i));
    grid on
    %绘制阶跃响应信号来判断是否稳定
    
    figure(2);
    subplot(1,2,i);
    stepplot(model);
    
    figure (3)
    G=model/(1-model);
    G=minreal(G);
    subplot(2,2,i);
    pzmap(G);
    title(tit(i));
    subplot(2,2,N+i);
     nyquist(G);
     figure(4);
     subplot(1,2,i);
     margin(G)
      
end




