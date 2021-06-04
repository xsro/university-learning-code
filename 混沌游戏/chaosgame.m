%混沌游戏，有n个点，试验NUM次，绘制得出的结果
% n：试验中的节点树
% NUM：试验次数
function p=chaosgame(n,NUM)
    plotq=0;recq=1;quickq=0;
    N=zeros(n,2);
    for i=1:n
        theta=pi*2/n;
        N(i,:)=[cos(i*theta),sin(i*theta)];
    end 
    now=rand(1,2);
    if plotq==1||quickq==1
        figure(n);
        hold on;axis equal;
        plot(N(:,1),N(:,2),'ro');
        plot(now(1),now(2),'bx');
    end
    if recq==1
    p=zeros(NUM,2);
    end
    for i=1:NUM
        x=ceil(rand()*n);
        aim=N(x,:);
        m=0.5;%rand();
        vec=aim-now;
        now=vec*m+now;
        if plotq==1
            plot(now(1),now(2),'b.');
            title(num2str(i));
        end
        if recq==1
            p(i,:)=now;
        end
    end
    if quickq==1
    plot(p(:,1),p(:,2),'.');
    title(strcat('定点数：',num2str(n),'动点运动',num2str(NUM),'次'));
    saveas(gca,strcat(num2str(NUM),'-',num2str(n),'.jpg'));
    close;
    end
end
