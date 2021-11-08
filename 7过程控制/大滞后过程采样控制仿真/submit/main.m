%set constants
K=10;
T=6;
tau0=2;
Ts_list=[0.1,1,1.5,2.5];

%build process model
s=tf('s');
Gs=K/(T*s+1)*exp(-tau0*s);
%use state space model for better accuracy
Gs=ss(Gs);

%design a Controller
Gcs=pidtune(Gs,"PID");

%plot result
figure();
hold on;
for Ts=Ts_list
    Gz=c2d(Gs,Ts,'zoh');
    Gcz=c2d(Gcs,Ts);
    Phi=feedback(series(Gcz,Gz),1);
    Phi.Name="Ts="+Ts;
    stepplot(Phi);
end
legend;hold off;
title("大滞后采样控制");

%save figure into .fig format
saveas(gcf,'result.fig','fig');