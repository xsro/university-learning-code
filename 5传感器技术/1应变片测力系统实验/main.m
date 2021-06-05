%��ȡ����
num=xlsread('data.xlsx');
W=num(1,:);
Uup=num(2,:);
Udown=num(3,:);
U=mean([Uup;Udown]);

%������ϲ���ͼ
x=[W,fliplr(W)];
y=[Uup,fliplr(Udown)];
p=polyfit(x,y,1);
f = polyval(p,x); 
plot(x,y,'o-',x,f,'-') 
xlabel('����W/g');
ylabel('�����ѹV/mV');
title('Ӧ��Ƭ����ϵͳ������������С���˷��������');
legend('ʵ������','��С���˷����','location','southeast');

%����������S��S=��V/��W(��VΪ�����ѹƽ���仯������W�����仯��)��
S=(max(U)-min(U))./(max(W)-min(W));

% �������������f1=��m/yF��S��100%��
% ʽ�Ц�mΪ�����ѹֵ(��β���ʱΪƽ��ֵ)�����ֱ�ߵ�����ѹƫ������
% yF��SΪ������ʱ��ѹ���ƽ��ֵ��������С���˷�����ֱ����ϣ�
e=abs(U-polyval(p,W));
el=max(e)./max(U);

sprintf('������%g ���������%g',S,el);
%������
% T=table(S,el,'VariableNames',{'������','���������'});
% display(T);