function symseq = ardec(symbol,pr,codeword,symlen)
%ARDEC 实现算术解码的函数
%   symseq:字符串
%   symbol:由字符组成的行向量
%   pr:字符出现的概率
%   codeword:码字
%   symlen:待解码字符串长度
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

