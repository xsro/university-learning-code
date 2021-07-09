function watermarked_image_int=DCT_encode(orig_image,watermark,DCT_coef,k,pn_sequence_zero)

    %�趨ͼ��ķֿ��СΪ8*8
    block_size=8;
    %����ˮӡͼ��ĸ߶ȺͿ��
    Hm=size(watermark,1);
    Wm=size(watermark,2);
    n=Hm*Wm;
    %��ˮӡͼ��ת��Ϊ1ά��������watermark��0��1����1��n�е�һά����
    watermark=reshape(watermark,1,n);

    %����ԭʼ����ͼ��
    Hc=size(orig_image,1);
    Wc=size(orig_image,2);
    Hc=floor(Hc/block_size)*block_size;
    Wc=floor(Wc/block_size)*block_size;
    orig_image=orig_image(1:Hc,1:Wc);
    c=Hc/block_size;
    d=Wc/block_size;
    m=c*d;
    %��������ͼ��ÿһ�ֿ�ķ���
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
    %ȡ����������ǰn��
    [~,Aidx]=sort(variance);
    idx=Aidx(c*d-n+1:c*d);
    %��ˮӡ��ϢǶ�뵽��������ǰn��
    variance_o=ones(1,c*d);
    variance_o(idx)=watermark;
    watermark_vector=variance_o;
    %Ƕ��ˮӡ
    x=1;y=1;
    for kk=1: m
        %�ֿ�DCT�任
        dct_block = dct2( orig_image(y: y + block_size-1, x: x+block_size-1));
        %�����(��������ǰn��)���ұ���ʾ��ˮӡ��ϢΪ0�Ŀ�����DCT��Ƶϵ��Ƕ��α�������
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
        %�ֿ�DCT���任
        watermarked_image(y: y + block_size-1, x: x+block_size-1) = idct2( dct_block) ;
        %����
        if (x + block_size) >= Wc
            x=1; y=y + block_size ;
        else
            x=x + block_size;
        end
    end
    watermarked_image_int = uint8( watermarked_image) ;
end
