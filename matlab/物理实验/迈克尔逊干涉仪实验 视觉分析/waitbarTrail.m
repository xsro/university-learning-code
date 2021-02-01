% 初始化进度条，并返回句柄
% e = lim(1+1/x)^x (x -> ∞)
f = waitbar(0,'1','Name','极限法求自然常数e值');
num=1000;
% 设置进度条背景颜色
set(f,'color','w');
% 设置x的最大取值
x = 2000;
% 在循环中加入进度条来显示计算过程状态
for k = 1:num
    % Update waitbar and message
    ek = (1+1/k)^k;
    string=sprintf('%s %12.9f %s','当前e值: ',ek,['已完成：',num2str(round(100*k/num)),'%']);
    display(string);clc;
    waitbar(k/num,f,string);
end