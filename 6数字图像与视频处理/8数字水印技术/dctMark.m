%图片加水印，提取出水印，并进行攻击测试
%林多   CSDN
%http://blog.csdn.net/zxc024000
%blog link:https://blog.csdn.net/zxc024000/article/details/49429405
%%%%%%%%%%%%
M=256; %原图像长度
N=32; %水印图像长度
K=8; %8x8的分块
I=zeros(M,M);%创建一个MxM矩阵，元素全是0
J=zeros(N,N);
BLOCK = zeros(K,K);
%显示原图像
subplot(5,2,1);%显示多幅图像，在第一个位置显示
I=imread('cameraman.tif');%将cameraman.tif读入I中
imshow(I);%显示图像
title('原始公开图像');%标题
%显示水印图像
subplot(5,2,2);
J=imread('21.bmp');
imshow(J);
title('水印图像');
%水印嵌入算法
for p=1:N %从1到32循环
 for q=1:N %从1到32循环
  x=(p-1)*K+1; y=(q-1)*K+1;
  BLOCK=I(x:x+K-1,y:y+K-1);%取相应元素保存到BLOCK中
  BLOCK=dct2(BLOCK);%二维离散余弦变换
  if J(p,q)==0 %如果元素为0
    a=-1;
  else
    a=1;
  end
  BLOCK=BLOCK*(1+a*0.03);  BLOCK=idct2(BLOCK);%反二维离散余弦变换
  I(x:x+K-1,y:y+K-1)=BLOCK;
 end
end
%显示嵌入水印后的图像
subplot(5,2,3);
imshow(I);
title('嵌入水印后的图像');
imwrite(I,'watermarked.bmp','bmp');%将I中的数据保存成watermarked.bmp
%从嵌入水印的图像中提取水印
I=imread('cameraman.tif');%未加水印的原图像
P=imread('watermarked.bmp');%水印图像
%提取水印算法
for p=1:N
for q=1:N
x=(p-1)*K+1;
y=(q-1)*K+1;
BLOCK1=I(x:x+K-1,y:y+K-1);%赋给BLOCK1元素
BLOCK2=P(x:x+K-1,y:y+K-1);%赋给BLOCK2元素
BLOCK1=idct2(BLOCK1);%对其本身进行反二维离散余弦变换
BLOCK2=idct2(BLOCK2);%对其本身进行反二维离散余弦变换
a=BLOCK2(1,1)/BLOCK1(1,1)-1;
if a<0
W(p,q)=0;
else
W(p,q)=1;
end
end
end
%显示提取的水印
subplot(5,2,4);
imshow(W);
title('从含水印图像中提取的水印');

%----------攻击测试-----------------------%

%----------中值攻击----------%
P1=imread('watermarked.bmp');
P1=double(P1(:,:,1));
P1=medfilt2(P1);%中值滤波
subplot(5,2,5);
imshow(P1,[]);
title('中值滤波攻击');
I1=imread('cameraman.tif');%未加水印的原图像
%提取水印算法
for p=1:N
for q=1:N
x=(p-1)*K+1;
y=(q-1)*K+1;
BLOCK1=I1(x:x+K-1,y:y+K-1);%赋给BLOCK1元素
BLOCK2=P1(x:x+K-1,y:y+K-1);%赋给BLOCK2元素
BLOCK1=idct2(BLOCK1);%对其本身进行反二维离散余弦变换
BLOCK2=idct2(BLOCK2);%对其本身进行反二维离散余弦变换
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
title('从含中值滤波图像中提取的水印');

%----------变小攻击----------%
P2=imread('watermarked.bmp');
P2=imresize(P2,0.5);%变为0.5倍，从256x256到128x128
subplot(5,2,7);
imshow(P2,[]);%显示变小后图像
title('变小攻击，变为128x128像素');
I2=imread('cameraman.tif');%未加水印的原图像
I2=imresize(I2,0.5);%原图像一样变小
%提取水印算法
for p=1:32
for q=1:32
x=(p-1)*4+1;
y=(q-1)*4+1;
BLOCK1=I2(x:x+4-1,y:y+4-1);%赋给BLOCK1元素
BLOCK2=P2(x:x+4-1,y:y+4-1);%赋给BLOCK2元素
BLOCK1=idct2(BLOCK1);%对其本身进行反二维离散余弦变换
BLOCK2=idct2(BLOCK2);%对其本身进行反二维离散余弦变换
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
title('从128x128图像中提取水印');

%-------旋转攻击-------%
P3=imread('watermarked.bmp');
P3=imrotate(P3,90);%逆时针旋转90度;
subplot(5,2,9);
imshow(P3,[]);
title('旋转攻击');
I3=imread('cameraman.tif');%未加水印的原图像
I3=imrotate(I3,90); %原图像逆时针旋转90度;
%提取水印算法
for p=1:N
for q=1:N
x=(p-1)*K+1;
y=(q-1)*K+1;
BLOCK1=I3(x:x+K-1,y:y+K-1);%赋给BLOCK1元素
BLOCK2=P3(x:x+K-1,y:y+K-1);%赋给BLOCK2元素
BLOCK1=idct2(BLOCK1);%对其本身进行反二维离散余弦变换
BLOCK2=idct2(BLOCK2);%对其本身进行反二维离散余弦变换
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
title('从含旋转图像中提取的水印');