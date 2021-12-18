%% 所有的单元测试都需要从matlab.unittest.TestCase继承
classdef MPC_Zero_Ref_test < matlab.unittest.TestCase
   
    %% 定义以Test为attribute的methods
    methods (Test)
        % 定义你自己的测试
        function testSingle(testCase) %function唯一的参数test是你的测试对象
            % Verifies single input case
                A=[1,0.1;0,2];
                B=[0;0.5];
                N=3;
                x_k=[5;5];
                Q=[1 0;0 1];
                R=0.1;
                F=[2,0;0,2];

                [M,C,Q_bar,R_bar,G,E,H,U_k]=MPC_Zero_Ref(A,B,N,x_k,Q,R,F);
                
                exp_U_k=[-18.5487;-3.2905;0.6465];
                testCase.verifyEqual(U_k,exp_U_k,"AbsTol",0.01); %比较实际输出与期待输出
        end
    end
end








