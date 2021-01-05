%绘制降压斩波电路输入输出比与占空比的关系（理论+实际）
getdata;
x=linspace(min(Div),max(Div),100);
y=1./x;
plot(Div,D,'o-',x,y);
legend('实际曲线','理论曲线');
xlabel('输入输出比Ui/Uo');
ylabel('占空比D');