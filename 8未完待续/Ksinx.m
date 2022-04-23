% THIS small script solve following problem
%  A is one point on y=sinx
%  O is the origin point
%  find the range of kAO (slope rate of line AO)

f=@(x)(tan(x)-x);
a=fsolve(f,4);
kmin=cos(a);
kmax=1;
figure();hold on;grid;
fplot(@(x)(sin(x)))
fplot(@(x)(kmin*x))
fplot(@(x)(kmax*x))
legend("sin(x)",sprintf("%g *x",kmax),sprintf("%g *x",kmin))
title("斜率最小值为cos(a)，a为tan(a)=a在4附近的解")