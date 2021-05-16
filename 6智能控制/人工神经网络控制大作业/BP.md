# BP神经网络算法概述

与最小二乘法的思想类似,BP神经网络算法是基于梯度法的搜索算法,使网络的实际输出值和期望值之间的误差均方误差最小。其可系统地求解多层前馈网络、隐层神经元连接权重的学习问题,已被广泛应用于解决汽轮机性能监测及故障诊断等问题。

BP算法主要包括两个部分:信号的正向传播和误差的反向传播。以3层结构为例,3层结构为输入层、隐藏层和输出层,各层完全互连,同一层之间没有互连。隐藏层可以具有一层或多层。在层之间流动的信号有两种:一种是工作信号,即在施加输入信号之后向前传播,直到在输出端产生实际输出为止,这是输入和权重的函数;另一种是误差信号,网络的实际输出与预期输出之间的差值从输出端开始逐层向后传播。

假设输入层$X$为$n$行1列,激活函数$f(·)$为单极性Sigmoid函数,则第一隐含层$h^1$(p行1列)和第二隐含层$h^2$(q行1列)分别可表示为:

$$
\begin{array}{l}
h_{p}^{1}=f\left(\sum w_{p n}^{1} \cdot x_{n}+\varphi_{p n}^{1}\right) \\
h_{q}^{2}=f\left(\sum w_{q p}^{2} \cdot h_{p}^{1}+\varphi_{p n}^{2}\right)
\end{array}
$$

进一步，输出层$Y_1$,$Y_2$可表示为

$$
\left\{\begin{array}{l}
Y_{1}=f\left(\sum w_{1 q}^{3} \cdot h_{q}^{2}+\varphi_{1 q}^{3}\right) \\
Y_{2}=f\left(\sum w_{2 q}^{3} \cdot h_{q}^{2}+\varphi_{2 q}^{3}\right)
\end{array}\right.
$$

联立以上三式,可得:

$$
\left\{\begin{array}{l}
Y_{1}=f\left(\sum w_{1 q}^{3} \cdot f\left(\sum w_{q p}^{2} \cdot f\left(\sum w_{p n}^{1} \cdot x_{n}+\varphi_{p n}^{1}\right)+\varphi_{p n}^{2}\right)+\varphi_{1 q}^{3}\right) \\
Y_{2}=f\left(\sum w_{2 q}^{3} \cdot f\left(\sum w_{q p}^{2} \cdot f\left(\sum w_{p n}^{1} \cdot x_{n}+\varphi_{p n}^{1}\right)+\varphi_{p n}^{2}\right)+\varphi_{2 q}^{3}\right)
\end{array}\right.
$$

BP算法主要用于BP神经网络权值和阈值的学习,其学习过程是由信号的正向传播与误差的反向传播两个过程组成。当一个样本输入网络并产生输出时,均方误差应为各输出单元误差平方之和,即:

$$
E^{(p)}=\frac{1}{2} \sum_{k=0}^{m-1}\left(d_{k}^{(p)}-Y_{k}^{(p)}\right)^{2}
$$

当所有样本都输入一次后,总误差为:

$$
E_{A}=\sum_{p=1}^{P} E^{(p)}=\frac{1}{2} \sum_{p=1}^{P} \sum_{k=0}^{m-1}\left(d_{k}^{(p)}-Y_{k}^{(p)}\right)^{2}
$$


根据梯度下降法,进入迭代,指导误差收敛并收敛于给定值。即为训练完成。