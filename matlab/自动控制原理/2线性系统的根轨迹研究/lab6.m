G2=tf(1,[1 0.6 0]);
% sisotool(G2)
info2=stepinfo(feedback(G2,1));
[z,p,k]=tf2zp(1,[1 0.6 0]);
G3=zpk([z,-4.87],p,k);
info3=stepinfo(feedback(G3,1));
Former=struct2table(info2)
New=struct2table(info3)
