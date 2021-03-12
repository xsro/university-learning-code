function plotSun(sun)
%plotSun 绘制给定太阳直射点位置时的全球昼夜长度曲线
x=-90:0.1:90;
y=daytime(x,sun);
plot(x,y);
title('给定直射点纬度地球昼夜长短分布');
xlabel('观察地纬度x');
ylabel('昼长/h');
ylim([0 24]);
grid;
set(gca,'XTick',[-90 -66.5 -23.5 0 23.5 66.5 90],...
    'XTickLabel', {'90\circ S','66.5 \circ S','23.5 \circ S','0 \circ','23.5 \circ N','66.5 \circ N','90 \circ N'})
end

