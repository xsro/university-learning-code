function Phi = G2Phi(G,Ci,Co)
%G2Phi 由飞行器的传递函数得到整个控制系统的闭环传递函数
%   这里使用的传递函数模型见该文件所在目录下的：飞行器控制系统的传递函数模型.png
%   Ci为内环控制器的传递函数
%   Co为外环控制器的传递函数
    G1=feedback(Ci*G,tf('s'));
    Phi=feedback(Co*G1,1);
end

