function output = daytime(man,sun)
%daytime - ������ҹ����
% Syntax: output = myFun(input)
% �۲�������γ��Ϊman
% ̫��ֱ�������γ��Ϊsun
% ����˵ص���ҹ����Ϊ���١�
    a=tand(man).*tand(sun);
    a=(a<1 & a>-1).*a+(a>=1)-(a<=-1);
    output=2*acos(a)*24/(2*pi);
end