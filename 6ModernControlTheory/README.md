# Modern Control theory Code

Here is codes for my two *Modern Control Theory* experiments lectured by our beautiful teacher. 
I write matlab live script and python jupyter notebook for both experiments.

## The environment I use

- MATLAB R2021a
- Conda 4.10.1 with [requirements.txt](requirements.txt)

## Some Tips

### on Python jupyter notebook for Control Theory

#### package installation

```bash
conda install numpy
conda install matplotlib
conda install -c conda-forge control
conda install -c conda-forge slycot #NOTE: the control.matlab.lqr need this module
```

#### Package Management

```sh
#https://stackoverflow.com/questions/50777849/from-conda-create-requirements-txt-for-pip3
conda list -e > requirements.txt
conda create --name controlTheory --file requirements.txt
```
