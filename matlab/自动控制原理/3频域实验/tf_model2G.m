function output=tf_model2G(inCon,outCon,Go)
%这个函数根据控制器参数和系统的传递函数求出被控对象的传递函数
pid_in=pid(inCon(1),inCon(2),inCon(3),0);%0.8+0.02*s% 内环控制器;
pid_out=pid(outCon(1),outCon(2),outCon(3),0);%4;% 外环控制器;
s=tf('s');
output=Go/(pid_out*pid_in-Go*pid_in*s-pid_out*pid_in*Go);
output=minreal(output);
end
