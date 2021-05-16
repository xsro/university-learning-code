# 绘制朱利判据表
# 参考https://blog.csdn.net/weixin_44044411/article/details/86475605

print('利用朱利判据判断离散系统的稳定性')
print('请输入特征方程的系数矩阵A')
A=[1,2,1.31,0.28]#input('A=')
n=len(A)#截取A的长度
for i in list(reversed(range(1,n))):
    print(A);#显示奇数行
    if i==1:
        if A[0]>0:
            print('系统稳定')
        else:
            print('系统不稳定')
        break
    B=list(reversed(A))
    print(B)#显示偶数行
    if A[0]<=0:
        print('首元素非正！系统不稳定')
        break
    k=B[0]/A[0]
    for index in range(0,len(A)):
        A[index]=A[index]-k*B[index]
    A.pop()
