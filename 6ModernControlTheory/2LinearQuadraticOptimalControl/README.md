# Linear Quadratic Optimal Control

## Question

Consider the following system

$$
\begin{cases}
\dot{x_1}&=&x_2\\
\dot{x_2}&=&u\\
y&=&x_1
\end{cases}
\Rightarrow
\begin{cases}
\dot{x}=\begin{pmatrix}
0 & 1 \\
0 & 0
\end{pmatrix}
x+
\begin{pmatrix}
0 \\ 1
\end{pmatrix}
\\
y=\begin{pmatrix}
1 & 0
\end{pmatrix}
u
\end{cases}
$$

with initial state of

$$
x(0)=
\begin{pmatrix}
1 & 2\\
\end{pmatrix}
^T
$$

And the cost function is:

$$
J = \int ^ \infty _0  [
x^T
\begin{pmatrix}
1 & 0 \\
 0 & 0
\end{pmatrix}
x
+
u^2
]\mathrm{d} t
$$

try to use **Linear Quadratic Optimal Control** to control the system.

## solutions

- for python solution, go to [ipynb](LinearQuadraticOptimalControl.ipynb)
- for matlab solution, go to [mlx](LinearQuadraticOptimalControl.mlx)

## Notes

### some Notes on Python jupyter notebook for Control Theory

## package installation

```bash
conda install numpy
conda install matplotlib
conda install -c conda-forge control
conda install -c conda-forge slycot #NOTE: the control.matlab.lqr need this module
```

## Package Management

```sh
#https://stackoverflow.com/questions/50777849/from-conda-create-requirements-txt-for-pip3
conda list -e > requirements.txt
conda create --name <env> --file requirements.txt
```
