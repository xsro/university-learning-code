function jury(input)
%myFun - Description
%
% Syntax: jury(input)
%
% Long description
disp('利用朱利判据判断离散系统的稳定性')
disp('请输入特征方程的系数矩阵A')
A=input;
n=size(A,2);%截取A的维数
for i=n:-1:1
    disp(A);%显示奇数行
    if i==1 
        if A(:)>0
            disp('系统稳定');
        else
            disp('系统不稳定');
        end
        break;
    end
    B=flip(A);
    disp(B);%显示偶数行
    if A(1,1)<=0
        disp('首元素非正！系统不稳定');
        break;
    end
    k=B(1,1)/A(1,1);
    A(1,:)=A(1,:)-k*B(1,:);
    A(:,i)=[];%A矩阵减维数
end
% ————————————————
% 版权声明：本文为CSDN博主「非线性光学元件」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
% 原文链接：https://blog.csdn.net/weixin_44044411/article/details/86475605
end