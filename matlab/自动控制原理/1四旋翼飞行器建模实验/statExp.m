function output=statExp(data,time)

%��ֵ̬ʹ��am�����棬Ҳ����ʹ�ý�Ծ��ֵ������
am=5;%��ֵ̬��ʹ�ý�Ծ�ͺŷ�ֵ������

%��ȡ���ݵ����ֵ��Ϣ
[maxi,idx]=max(data);

%���㳬����
output.Overshoot=(maxi-am)/am;
%������̬���
output.ess=(data(end)-am)/am;
%��ֵʱ��
output.PeakTime=time(idx);
%�������ʱ�䣬matlab��Ĭ����2%������
ST=0.02;
for i=1:length(data)
    if i<am*(1+ST) && i>am*(1-ST)
        break;
    end
end
if i<length(data)
output.SettlingTime=time(i);
end




