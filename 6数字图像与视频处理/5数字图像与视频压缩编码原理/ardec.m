function symseq = ardec(symbol,pr,codeword,symlen)
%ARDEC ʵ����������ĺ���
%   symseq:�ַ���
%   symbol:���ַ���ɵ�������
%   pr:�ַ����ֵĸ���
%   codeword:����
%   symlen:�������ַ�������
    format long e
    high_range=zeros(length(pr));
    for k=1:length(pr)
        high_range(k)=sum(pr(1:k));
    end
    low_range=[0 high_range(1:length(pr)-1)];
    prmin=min(pr);
    symseq='';
    for i=1:symlen
        idx=find(low_range<=codeword, 1, 'last' );
        codeword=codeword-low_range(idx);
        if abs(codeword-pr(idx))<0.01*prmin
            idx=idx+1;
            codeword=0;
        end
        symseq(i)=symbol(idx);
        codeword=codeword/pr(idx);
        if abs(codeword) < 0.01*prmin
            i=symlen+1;
        end
    end
end

