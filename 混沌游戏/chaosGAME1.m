
function chaosGAME1(n,NUM)%nΪƽ��̶�������NUMΪ����P�˶�����
    N=zeros(n,2);%N��¼��������
    for i=1:n
        theta=pi*2/n;
        N(i,:)=[cos(i*theta),sin(i*theta)];
    end 
    now=rand(1,2);
        hold on;axis equal;
        plot(N(:,1),N(:,2),'ro');
        plot(now(1),now(2),'bx');
    p=zeros(NUM,2);%p��¼��������
    for i=1:NUM
        x=ceil(rand()*n);
        aim=N(x,:);
        m=0.5;%rand();
        vec=aim-now;
        now=vec*m+now;
        p(i,:)=now;
    end
    plot(p(:,1),p(:,2),'.');axis equal;
    title(strcat('n=',num2str(n),' NUM=',num2str(NUM)));
    hold off;
    %saveas(gca,strcat(num2str(NUM),'-',num2str(n),'.jpg'));
end