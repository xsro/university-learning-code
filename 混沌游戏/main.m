NUM=100000;
%��n=3ʱ�����Եõ�л����˹��������
clf;
chaosGAME1(3,NUM);
saveas(gca,'pics/Sierpinski-triangle.jpg');
%��n=5ʱ�ķ���
clf;
chaosGAME1(5,NUM);
saveas(gca,'pics/n5.jpg');

 %�ֱ����ʵ��1000��10000��100000����ʵ�������ͼƬ
 %�ڵ�����ȡ��20
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