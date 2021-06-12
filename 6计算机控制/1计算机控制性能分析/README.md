# README

主要内容和相关解释都在实时脚本[main.mlx](main.mlx)中。该文件需要使用matlab打开。

## 关于离散系统波特图的绘制说明

[链接](https://wenku.baidu.com/view/49da289e06a1b0717fd5360cba1aa81144318fc6.html)中使用的方法是有问题的，其使用如下代码来绘制波特图

```matlab
[num,den]=tfdata(sysc); %获取连续系统的分子分母系数
w=logspace(-1,10);
dbode(num,den,0.01); %使用上面获取的连续系统的分子分母来作为离散系统的分子分母，这样做是错误的
dbode(num,den,0.01,w);
```

正确的绘制方法应该是

```matlab
Ts=0.01;
sysd=c2d(sysc,Ts,'zoh'); %连续系统离散化
w=logspace(-1,10);
bode(sysd)
bode(sysd,w)
```
