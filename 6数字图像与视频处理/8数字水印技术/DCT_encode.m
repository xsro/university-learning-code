function watermarked_image_int=DCT_encode(orig_image,watermark,DCT_coef,k,pn_sequence_zero)

    %设定图像的分块大小为8*8
    block_size=8;
    %计算水印图像的高度和宽度
    Hm=size(watermark,1);
    Wm=size(watermark,2);
    n=Hm*Wm;
    %将水印图像转变为1维行向量，watermark由0，1构成1行n列的一维数组
    watermark=reshape(watermark,1,n);

    %处理原始载体图像
    Hc=size(orig_image,1);
    Wc=size(orig_image,2);
    Hc=floor(Hc/block_size)*block_size;
    Wc=floor(Wc/block_size)*block_size;
    orig_image=orig_image(1:Hc,1:Wc);
    c=Hc/block_size;
    d=Wc/block_size;
    m=c*d;
    %计算载体图像每一分块的方差
    xx=1;
    mean=zeros(1,c*d);
    variance=zeros(1,c*d);
    for j=1:c
        for i=1:d 
            t=orig_image((1+(j-1)*8):j*8,(1+(i-1)*8):i*8);
            mean(xx)=1/64*sum(sum(t));
            variance(xx)=1/64*sum(sum((t-mean(xx)).^2));
            xx=xx+1;
        end
    end
    %取出方差最大的前n块
    [~,Aidx]=sort(variance);
    idx=Aidx(c*d-n+1:c*d);
    %将水印信息嵌入到方差最大的前n块
    variance_o=ones(1,c*d);
    variance_o(idx)=watermark;
    watermark_vector=variance_o;
    %嵌入水印
    x=1;y=1;
    for kk=1: m
        %分块DCT变换
        dct_block = dct2( orig_image(y: y + block_size-1, x: x+block_size-1));
        %纹理大(方差最大的前n块)并且被标示的水印信息为0的块在其DCT中频系数嵌入伪随机序列
        tt= 1;
        if watermark_vector(kk) ==0
            for ii=1: block_size
                for jj=1: block_size
                    if(DCT_coef(jj,ii)==1)
                        dct_block(ii,ii) =dct_block(ii,ii) +k * pn_sequence_zero(tt) ;
                        tt=tt+1 ;
                    end
                end
            end
        end
        %分块DCT反变换
        watermarked_image(y: y + block_size-1, x: x+block_size-1) = idct2( dct_block) ;
        %换行
        if (x + block_size) >= Wc
            x=1; y=y + block_size ;
        else
            x=x + block_size;
        end
    end
    watermarked_image_int = uint8( watermarked_image) ;
end
