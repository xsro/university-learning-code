function chaosgame2(n,NUM)
N=zeros(n,2);
for i=1:n
    theta=pi*2/n;
    N(i,:)=[cos(i*theta),sin(i*theta)];
end 
figure(n);
hold on;
plot(N(:,1),N(:,2),'ro');axis equal;
now=rand(1,2);
plot(now(1),now(2),'bx');
p=zeros(NUM,2);
for i=1:NUM
x=ceil(rand()*n);
aim=N(x,:);
m=0.5;%rand();
vec=aim-now;
now=vec*m+now;
plot(now(1),now(2),'b.');
title(num2str(i));
p(i,:)=now;
end
hold off;