# 实验一 状态反馈与状态观测器

## 二、实验要求

给定的系统为：

$$
\dot{x}=\begin{pmatrix}
   -2 & 2 & -1 \\
   0 & -2 & 0 \\
   1 & -1 & 0
\end{pmatrix}
x
+\begin{pmatrix}
-1 \\ 1 \\-1
\end{pmatrix}
u\\

x(0)=\begin{pmatrix}
   2 \\-1\\1.6
\end{pmatrix},

y=\begin{pmatrix}
1 & -1 & 0
\end{pmatrix}
x
$$

求：

1. 分析被控系统的能控性和能观测性；
1. 根据给出的性能指标要求，用极点配置的方法设计状态反馈控制器。可否通过状态反馈将系统极点配置在-1+i，-2 和-1-i 处？如可以，求出上述极点配置的反馈增益向量，并绘制零输入系统状态响应曲线；
1. 根据状态观测器设计的要求，设计全维状态观测器，实现状态观测器的期望极点配置。若系统状态无法直接测量，可否通过状态观测器获取状态变量？若可以，设计一个极点位于-1，-2 和-3 处的全维状态观测器，并绘制在观测器初始状态为 0 时的零输入观测器状态响应曲线；
1. 绘制系统状态与观测器状态的状态误差响应曲线。
1. 分析实验结果，说明状态反馈的优缺点。

## 参考链接

1. Introduction: State-Space Methods for Controller Design.<https://ctms.engin.umich.edu/CTMS/index.php?example=Introduction&section=ControlStateSpace>
