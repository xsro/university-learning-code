function output = statTheo(G)
%计算给定传递函数下的动态特性数据和稳态误差
%
% Syntax: output = myFun(input)
%
% Long description
infoTheo=stepinfo(G);
output.Overshoot=infoTheo.Overshoot;
%C=tf(1,[1,0])*G;
output.ess=dcgain(G)-1;
output.PeakTime=infoTheo.PeakTime;
output.SettlingTime=infoTheo.SettlingTime;
end

