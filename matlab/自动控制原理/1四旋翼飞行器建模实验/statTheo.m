function output = statTheo(G)
%����������ݺ����µĶ�̬�������ݺ���̬���
%
% Syntax: output = myFun(input)
%
% Long description
infoTheo=stepinfo(G);
output.Overshoot=infoTheo.Overshoot;
%C=tf(1,[1,0])*G;
output.ess=dcgain(G)-1;
output.PeakTime=infoTheo.PeakTime;
output.SettlingTime=infoTheo.SettlingTime;
end

