function output = daytime(man,sun)
%daytime - 计算昼夜长短
% Syntax: output = myFun(input)
% 观察者所在纬度为man
% 太阳直射点所在纬度为sun
% 计算此地的昼夜长短为多少。
    a=tand(man).*tand(sun);
    a=(a<1 & a>-1).*a+(a>=1)-(a<=-1);
    output=2*acos(a)*24/(2*pi);
end