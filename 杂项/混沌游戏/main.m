NUM=100000;
%当n=3时，可以得到谢尔宾斯基三角形
clf;
chaosGAME1(3,NUM);
saveas(gca,'pics/Sierpinski-triangle.jpg');
%当n=5时的分形
clf;
chaosGAME1(5,NUM);
saveas(gca,'pics/n5.jpg');

 %分别绘制实验1000，10000，100000三种实验次数的图片
 %节点数从取到20
 n=3;
 for k=1:4
     clf;
    for j=1:3
        i=3*(k-1)+j;
        subplot(n,3,3*j-2);
        chaosGAME1(i,1000);
        subplot(n,3,3*j-1);
        chaosGAME1(i,10000);
        subplot(n,3,3*j);
        chaosGAME1(i,100000);
    end
    saveas(gca,strcat('pics/',num2str(k),'.jpg'));
 end