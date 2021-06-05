
[x,y]=meshgrid(-90:0.1:90,-23.5:0.1:23.5);
time=daytime(x,y);

% ���� figure
figure1 = figure;

% ���� axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% ����ͼ��
h=mesh(x,y,time);

title('ĳ����ҹ������õغ�̫��ֱ���γ��֮��Ĺ�ϵ');
xlabel('�۲��γ��x');
ylabel('̫��ֱ���γ��y');
zlabel('�糤/h');
% ȡ�������е�ע���Ա����������� X ��Χ
% xlim(axes1,[-90 90]);
% ȡ�������е�ע���Ա����������� Y ��Χ
% ylim(axes1,[-23.5 23.5]);
zlim(axes1,[0,24]);
view(axes1,[-37.5 30]);
grid(axes1,'on');
% ������������������
set(axes1,'XTick',[-90 -66.5 -23.5 0 23.5 66.5 90],...
    'XTickLabel', {'90\circ S','66.5 \circ S','23.5 \circ S','0 \circ','23.5 \circ N','66.5 \circ N','90 \circ N'},...
    'YTick',[-23.5 -10 0 10 23.5],...
    'YTickLabel',{'23.5 \circ S','10 \circ S','0 \circ','10 \circ S','23.5 \circ N'});

%b����ͼƬ
saveas(gcf,'result/3d.jpg');
