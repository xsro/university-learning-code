function watermark=DCT_decode(watermarked_image,orig_image,DCT_coef,pn_sequence_zero)
    block_size =8;
    %����ԭʼ����ͼ��
    Hw = size( watermarked_image,1);
    Ww = size( watermarked_image,2);
    c = Hw / 8;
    d = Ww / 8; 
    m = c * d;

    %����ˮӡͼ��
    orig_watermark = imread('21.bmp');
    Ho = size( orig_watermark ,1);
    Wo = size( orig_watermark ,2);
    n = Ho * Wo;
    
    %��ȡˮӡ
    x=1;
    y=1;
    for kk=1:m
        %��ԭʼͼ��ʹ����ͼ��ֱ���зֿ�DCT
        det_block1 = dct2(watermarked_image(y: y + block_size-1, x: x+block_size-1));
        det_block2 = dct2(orig_image(y: y +block_size-1, x: x+block_size-1));
        tt=1;
        for ii=1:block_size
            for jj=1:block_size
                if DCT_coef(jj,ii) == 1
                    sequence(tt) = det_block1(jj,ii) - det_block2(jj,ii);
                    tt=tt +1;
                end
            end
        end
        %�����������е������
        if sequence == 0
            correlation(kk) = 0;
        else
            correlation(kk) = corr2(pn_sequence_zero , sequence);
        end
        %����
        if x + block_size >= Ww
            x=1;
            y=y + block_size;
        else
            x=x + block_size ;
        end
    end
    %ʹ���������Ϊ�Ҷ�ֵ
    %�̲���Ϊ������0.5Ƕ��0,������0.5,�����������Ƕ��
    watermark_vector=correlation(1:m);
    %����ԭʼͼ��ķ���
    xx=1;
    for j=1:c
        for i=1:d
            t=orig_image((1 +(j-1) *8): j*8, (1+(i-1)*8): i*8);
            mean(xx) = 1/64 * sum( sum(t));
            variance( xx) = 1/64 * sum( sum( (t-mean(xx)).^2));
        xx=xx+1;
        end
    end
    %ȡ����������ǰn��
    A = sort(variance);
    B = A((c*d-n+1): c*d);
    %����ԭʼͼ�񷽲�����ǰn���λ�ð�ˮӡ��Ϣ��ȡ����
    variance_o= ones(1, n);
    for g=1:n
        for h=1:c*d
            if B(g) == variance(h)
                variance_o(g) = watermark_vector (h) ;
                h = c*d;
            end
        end
    end
    watermark_vector = variance_o;
    %����Ƕ�˵�ͼ����Ϣ
    watermark = reshape( watermark_vector(1:Ho* Wo) ,Ho, Wo);
end