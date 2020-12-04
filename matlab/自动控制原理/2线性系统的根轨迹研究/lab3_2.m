G=tf([1 2],conv([1 4 5],[1 4 5]));
K=71.1;
Phi=feedback(G*K,1);
info=stepinfo(Phi);
step(Phi)
