%确定等效开环传递函数模型
G=tf([1 2],conv([1 4 5],[1 4 5]));
figure(1);
%绘制零极点分布图
%pzmap(G);
 figure(2)
%绘制根轨迹
rlocus(G)
%确定增益及其相应的闭环极点
rlocfind(G)