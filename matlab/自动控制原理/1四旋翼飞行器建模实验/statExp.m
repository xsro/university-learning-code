function output=statExp(data,time)

%稳态值使用am来代替，也就是使用阶跃幅值来代替
am=5;%稳态值，使用阶跃型号幅值来代替

%获取数据的最大值信息
[maxi,idx]=max(data);

%计算超调量
output.Overshoot=(maxi-am)/am;
%计算稳态误差
output.ess=(data(end)-am)/am;
%峰值时间
output.PeakTime=time(idx);
%计算调节时间，matlab中默认是2%的误差带
ST=0.02;
for i=1:length(data)
    if i<am*(1+ST) && i>am*(1-ST)
        break;
    end
end
if i<length(data)
output.SettlingTime=time(i);
end




