outCon=[2 0 0;3 0 0;2 0 0];
inCon=[1 0 0.03;1 0 0.03;1 0.2 0.03];
[~,sheets] = xlsfinfo('data.xlsx');
num=xlsread('data.xlsx', 'LCY' );
data = zeros(3,8,'double');
for i=1:3
    x=num(:,2*i-1);
    y=num(:,2*i);
    G=Gtheo(inCon(i,:),outCon(i,:));
    theo=statTheo(G);
    data(i,1:4)=[theo.Overshoot,theo.ess,theo.PeakTime,theo.SettlingTime];
    expr=statExp(y,x);
    data(i,5:8)=[expr.Overshoot,expr.ess,expr.PeakTime,expr.SettlingTime];
end
Overshoot_Theo=data(:,1);
ess_Theo=data(:,2);
PeakTime_Theo=data(:,3);
SettlingTime_Theo=data(:,4);

Overshoot_Exp=data(:,5);
ess_Exp=data(:,6);
PeakTime_Exp=data(:,7);
SettlingTime_Exp=data(:,8);

T=table(outCon,inCon,Overshoot_Theo,ess_Theo,PeakTime_Theo,SettlingTime_Theo,Overshoot_Exp,ess_Exp,PeakTime_Exp,SettlingTime_Exp);
writetable(T,'result.xlsx')

