obj=videoinput('winvideo');%������Ƶ����
set(obj,'TriggerRepeat',Inf);%�趨��������
set(obj,'FramesPerTrigger',1);%�趨ÿ�δ�������֡��
set(obj,'FrameGrabInterval',6);%�趨����֡��ʱ������Ĭ�ϵ���1����ÿһ֡��ץȡ���������Ϊ3����ÿ3֡ȡһ֡��
objres=get(obj,'VideoResolution');%�õ���Ƶ�ֱ���
nBands=get(obj,'NumberOfBands');%�õ�ɫ����Ŀ��rgb���൱������ͨ����
hImage=image(zeros(objres(2),objres(1),nBands));
preview(obj,hImage);;%Ԥ��
t=clock;
k=1;
%h=preview(obj);

n=1;
tic;
val=[];

     %-------------------------------------------

while n<100000  %��ȡͼƬ�ĸ���
if etime(clock,t)>=0.1; %����ʱ��ѭ����ȡͼƬ������cputime����Ҳ�����ʱ��ѭ�����÷���ͬ��ֻ�������Ǹ���CPU��Ƶ�����
t=clock;
frame=getsnapshot(obj);
a=ycbcr2rgb(frame);
str=['capture',num2str(n),'.jpg'];
imwrite(a,str,'jpg');
 val(n+1)=a(1,1,1);
    %if val(n)>=20 && val(n)-val(n-1)>0
        %k=k+1;
    %end
n=n+1;
end
end

toc;
run('shiyan2.m');

    
