
[x,y]=meshgrid(-90:0.1:90,-23.5:0.1:23.5);
time=daytime(x,y);

% 创建 figure
figure1 = figure;

% 创建 axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% 绘制图形
h=mesh(x,y,time);

title('某地昼夜长短与该地和太阳直射点纬度之间的关系');
xlabel('观察地纬度x');
ylabel('太阳直射点纬度y');
zlabel('昼长/h');
% 取消以下行的注释以保留坐标区的 X 范围
% xlim(axes1,[-90 90]);
% 取消以下行的注释以保留坐标区的 Y 范围
% ylim(axes1,[-23.5 23.5]);
zlim(axes1,[0,24]);
view(axes1,[-37.5 30]);
grid(axes1,'on');
% 设置其余坐标区属性
set(axes1,'XTick',[-90 -66.5 -23.5 0 23.5 66.5 90],...
    'XTickLabel', {'90\circ S','66.5 \circ S','23.5 \circ S','0 \circ','23.5 \circ N','66.5 \circ N','90 \circ N'},...
    'YTick',[-23.5 -10 0 10 23.5],...
    'YTickLabel',{'23.5 \circ S','10 \circ S','0 \circ','10 \circ S','23.5 \circ N'});

%b保存图片
saveas(gcf,'result/3d.jpg');
