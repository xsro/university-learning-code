%ͼƬ��ˮӡ����ȡ��ˮӡ�������й�������
%�ֶ�   CSDN
%http://blog.csdn.net/zxc024000
%blog link:https://blog.csdn.net/zxc024000/article/details/49429405
%%%%%%%%%%%%
M=256; %ԭͼ�񳤶�
N=32; %ˮӡͼ�񳤶�
K=8; %8x8�ķֿ�
I=zeros(M,M);%����һ��MxM����Ԫ��ȫ��0
J=zeros(N,N);
BLOCK = zeros(K,K);
%��ʾԭͼ��
subplot(5,2,1);%��ʾ���ͼ���ڵ�һ��λ����ʾ
I=imread('cameraman.tif');%��cameraman.tif����I��
imshow(I);%��ʾͼ��
title('ԭʼ����ͼ��');%����
%��ʾˮӡͼ��
subplot(5,2,2);
J=imread('21.bmp');
imshow(J);
title('ˮӡͼ��');
%ˮӡǶ���㷨
for p=1:N %��1��32ѭ��
 for q=1:N %��1��32ѭ��
  x=(p-1)*K+1; y=(q-1)*K+1;
  BLOCK=I(x:x+K-1,y:y+K-1);%ȡ��ӦԪ�ر��浽BLOCK��
  BLOCK=dct2(BLOCK);%��ά��ɢ���ұ任
  if J(p,q)==0 %���Ԫ��Ϊ0
    a=-1;
  else
    a=1;
  end
  BLOCK=BLOCK*(1+a*0.03);  BLOCK=idct2(BLOCK);%����ά��ɢ���ұ任
  I(x:x+K-1,y:y+K-1)=BLOCK;
 end
end
%��ʾǶ��ˮӡ���ͼ��
subplot(5,2,3);
imshow(I);
title('Ƕ��ˮӡ���ͼ��');
imwrite(I,'watermarked.bmp','bmp');%��I�е����ݱ����watermarked.bmp
%��Ƕ��ˮӡ��ͼ������ȡˮӡ
I=imread('cameraman.tif');%δ��ˮӡ��ԭͼ��
P=imread('watermarked.bmp');%ˮӡͼ��
%��ȡˮӡ�㷨
for p=1:N
for q=1:N
x=(p-1)*K+1;
y=(q-1)*K+1;
BLOCK1=I(x:x+K-1,y:y+K-1);%����BLOCK1Ԫ��
BLOCK2=P(x:x+K-1,y:y+K-1);%����BLOCK2Ԫ��
BLOCK1=idct2(BLOCK1);%���䱾����з���ά��ɢ���ұ任
BLOCK2=idct2(BLOCK2);%���䱾����з���ά��ɢ���ұ任
a=BLOCK2(1,1)/BLOCK1(1,1)-1;
if a<0
W(p,q)=0;
else
W(p,q)=1;
end
end
end
%��ʾ��ȡ��ˮӡ
subplot(5,2,4);
imshow(W);
title('�Ӻ�ˮӡͼ������ȡ��ˮӡ');

%----------��������-----------------------%

%----------��ֵ����----------%
P1=imread('watermarked.bmp');
P1=double(P1(:,:,1));
P1=medfilt2(P1);%��ֵ�˲�
subplot(5,2,5);
imshow(P1,[]);
title('��ֵ�˲�����');
I1=imread('cameraman.tif');%δ��ˮӡ��ԭͼ��
%��ȡˮӡ�㷨
for p=1:N
for q=1:N
x=(p-1)*K+1;
y=(q-1)*K+1;
BLOCK1=I1(x:x+K-1,y:y+K-1);%����BLOCK1Ԫ��
BLOCK2=P1(x:x+K-1,y:y+K-1);%����BLOCK2Ԫ��
BLOCK1=idct2(BLOCK1);%���䱾����з���ά��ɢ���ұ任
BLOCK2=idct2(BLOCK2);%���䱾����з���ά��ɢ���ұ任
a=BLOCK2(1,1)/BLOCK1(1,1)-1;
if a<0
W1(p,q)=0;
else
W1(p,q)=1;
end
end
end
subplot(5,2,6);
imshow(W1);
title('�Ӻ���ֵ�˲�ͼ������ȡ��ˮӡ');

%----------��С����----------%
P2=imread('watermarked.bmp');
P2=imresize(P2,0.5);%��Ϊ0.5������256x256��128x128
subplot(5,2,7);
imshow(P2,[]);%��ʾ��С��ͼ��
title('��С��������Ϊ128x128����');
I2=imread('cameraman.tif');%δ��ˮӡ��ԭͼ��
I2=imresize(I2,0.5);%ԭͼ��һ����С
%��ȡˮӡ�㷨
for p=1:32
for q=1:32
x=(p-1)*4+1;
y=(q-1)*4+1;
BLOCK1=I2(x:x+4-1,y:y+4-1);%����BLOCK1Ԫ��
BLOCK2=P2(x:x+4-1,y:y+4-1);%����BLOCK2Ԫ��
BLOCK1=idct2(BLOCK1);%���䱾����з���ά��ɢ���ұ任
BLOCK2=idct2(BLOCK2);%���䱾����з���ά��ɢ���ұ任
a=BLOCK2(1,1)/BLOCK1(1,1)-1;
if a<0
W2(p,q)=0;
else
W2(p,q)=1;
end
end
end
subplot(5,2,8);
imshow(W2);
title('��128x128ͼ������ȡˮӡ');

%-------��ת����-------%
P3=imread('watermarked.bmp');
P3=imrotate(P3,90);%��ʱ����ת90��;
subplot(5,2,9);
imshow(P3,[]);
title('��ת����');
I3=imread('cameraman.tif');%δ��ˮӡ��ԭͼ��
I3=imrotate(I3,90); %ԭͼ����ʱ����ת90��;
%��ȡˮӡ�㷨
for p=1:N
for q=1:N
x=(p-1)*K+1;
y=(q-1)*K+1;
BLOCK1=I3(x:x+K-1,y:y+K-1);%����BLOCK1Ԫ��
BLOCK2=P3(x:x+K-1,y:y+K-1);%����BLOCK2Ԫ��
BLOCK1=idct2(BLOCK1);%���䱾����з���ά��ɢ���ұ任
BLOCK2=idct2(BLOCK2);%���䱾����з���ά��ɢ���ұ任
a=BLOCK2(1,1)/BLOCK1(1,1)-1;
if a<0
W3(p,q)=0;
else
W3(p,q)=1;
end
end
end
subplot(5,2,10);
imshow(W3);
title('�Ӻ���תͼ������ȡ��ˮӡ');