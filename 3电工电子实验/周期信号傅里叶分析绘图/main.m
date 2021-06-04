[num,txt,~] = xlsread('data.xlsx');
n=num(end,:);
x=num(1,:);
y=num(2:end-1,:);
ti=string(txt(3:9,1));
for i=1:7
    stem(x,y(i,:),'filled');
    title(ti(i));
    for j=0:10
    text(x(j+1),y(i,j+1)+0.2,num2str(y(i,j+1),'%.3f '));
    end
    xlabel('ÆµÂÊ/kHz');xlim([-10,110]);
    ylabel('µçÑ¹/V');
    grid on;
    saveas(gcf,strcat( ti(i),'.jpg'));
    
end