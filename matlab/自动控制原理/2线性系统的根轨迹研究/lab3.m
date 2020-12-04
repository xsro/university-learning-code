G=tf([1 2],conv([1 4 5],[1 4 5]));
K1=70;
K2=80;
for i=1:10
    K=(K1+K2)/2;
    Phi=feedback(G*K,1);
    info=stepinfo(Phi);
    if isnan(info.RiseTime)
        K2=K;
    else
        K1=K;
    end 
end
step(Phi)

