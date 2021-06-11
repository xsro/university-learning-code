function G = Phi2G(Phi,Ci,Co)
%Phi2G 通过控制系统的完整传递函数来计算飞行器的传递函数
%   由于种种原因我们无法认为Phi2G和G2Phi是互为逆运算
%   可能是我进行数学转换的时候出错了
%   Phi 整个控制系统传递函数，通常为系统辨识出来的传递函数
%   Ci,Co分别为内外环控制器传递函数
    s=tf('s');
    G=Phi/(Co*Ci-Phi*Ci*s-Co*Ci*Phi);
    G=minreal(G);
end

