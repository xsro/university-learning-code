function plotSun(sun)
%plotSun ���Ƹ���̫��ֱ���λ��ʱ��ȫ����ҹ��������
x=-90:0.1:90;
y=daytime(x,sun);
plot(x,y);
title('����ֱ���γ�ȵ�����ҹ���̷ֲ�');
xlabel('�۲��γ��x');
ylabel('�糤/h');
ylim([0 24]);
grid;
set(gca,'XTick',[-90 -66.5 -23.5 0 23.5 66.5 90],...
    'XTickLabel', {'90\circ S','66.5 \circ S','23.5 \circ S','0 \circ','23.5 \circ N','66.5 \circ N','90 \circ N'})
end

