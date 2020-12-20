%绘制俯仰通道的时域响应
%分别画出不同组的数据对应的图片（3张图）
[~,sheets] = xlsfinfo('data.xlsx');
outCon=[2 0 0;3 0 0;2 0 0];
inCon=[1 0 0.03;1 0 0.03;1 0.2 0.03];
figure(1);
N=3;

for i=1:3
    figure(i);
    hold on
    for sheet=1:N
        num=xlsread('data.xlsx',sheet);
        x=num(:,2*i-1);
        y=num(:,2*i);
        plot(x,y./5);
    end
    G=Gtheo(inCon(i,:),outCon(i,:));
    stepplot(G,'k-');
    hold off
    title(strcat("实验曲线",num2str(i)));
end