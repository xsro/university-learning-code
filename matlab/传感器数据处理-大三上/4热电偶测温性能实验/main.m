%��ȡ����
num=xlsread('data.xlsx');
X1=num(1,:);
Y1=num(2,:);

%������ϲ���ͼ
x=X1;
y=Y1;
p=polyfit(x,y,1);
f = polyval(p,x); 
plot(x,y,'o-',x,f,'r-') ;
xlabel('T/��');
ylabel('V/mV');
grid

%����180���϶�ʱ�ĵ�ѹֵ
polyval(p,180)