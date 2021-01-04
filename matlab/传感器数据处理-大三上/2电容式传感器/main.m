%��ȡ����
num=xlsread('data.xlsx');
X1=num(1,:);
Y1=num(2,:);
X2=num(3,:);
Y2=num(4,:);
X2=X2(~isnan(X2));
Y2=Y2(~isnan(Y2));

%������ϲ���ͼ
x=[X1,fliplr(X2)];
y=[Y1,fliplr(Y2)];
p=polyfit(x,y,1);
f = polyval(p,x); 
plot(x,y,'o-',x,f,'r-') ;
xlabel('����λ��X/mm');
ylabel('��ѹV/mV');
title('ʵ�����ߺ���С���˷��������');
legend('ʵ������','��С���˷��������');
grid

%����ϵͳ�����ȣӡ��ӣ����֣����أ�ʽ�Ц���Ϊ��ѹ�仯������Ϊ��Ӧ������λ�Ʊ仯����
S=(max(y)-min(y))./(max(x)-min(x));

% �������������f1=��m/yF��S��100%��
e=abs(x-polyval(p,x));
el=max(e)./max(y);

%������
sprintf('������%g���������%g',S,el);
% T=table(S,el,'VariableNames',{'������','���������'});
% display(T);