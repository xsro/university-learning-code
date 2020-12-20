Gi=tf('s');
inCon=[2 0 0];
outCon=[1 0 0.03];
Phi=G2model(Gi,inCon,outCon)
Gi2=model2G(Phi,inCon,outCon)
