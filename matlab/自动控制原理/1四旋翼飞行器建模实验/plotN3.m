%绘制出一张图片 使用subplot
[~,sheets] = xlsfinfo('data.xlsx');
outCon=[2 0 0;3 0 0;2 0 0];
inCon=[1 0 0.03;1 0 0.03;1 0.2 0.03];
figure(1);
N=size(sheets);
N=N(2);
groups=['A' 'B' 'C' 'D'];
for sheet=1:N
    num=xlsread('data.xlsx',sheet);
    for i=1:3
        x=num(:,2*i-1);
        y=num(:,2*i);
        subplot(N,3,3*sheet-3+i);
        plot(x,y./5);
        hold on;
        step(Gtheo(inCon(i,:),outCon(i,:)));
        hold off
        %group=sheets{sheet};
        group=groups(sheet);
        title(strcat(group,'组 图',num2str(i)));
    %     f=fit(x,y,'smoothingspline');
    %     plot(f,x,y);
    %     max(y)
    end
end
% figure(2);
%  num=xlsread('data.xlsx',2);
%   for i=1:3
%         x=num(:,6+2*i-1);
%         y=num(:,6+2*i);
%         subplot(1,3,i);
%         plot(x,y./5);
%         title(strcat(sheets{sheet},"lab2",num2str(i)));
%   end
   
