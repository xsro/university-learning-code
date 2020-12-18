%绘制理论上不同控制参数的响应模型
outCon=[2 0 0;3 0 0;2 0 0];
inCon=[1 0 0.03;1 0 0.03;1 0.2 0.03];
figure(1);hold on;
leg = strings(1,3);
for i=1:3
    in=inCon(i,:);
    out=outCon(i,:);
    G=Gtheo(in,out);
    s=stepplot(G);
    leg(i)=strcat('内环',num2str(in),' 外环',num2str(out));
end
  legend(leg(1),leg(2),leg(3))
