function [arcode_low,arcode_high] = arenc(symbol,pr,seqin)
%ARENC 实现算算术编码的函数
%   symbol:字符行向量
%   pr:字符出现的概率
%   seqin:待编码字符
    high_range=zeros(length(pr));
    for k=1:length(pr)
        high_range(k)=sum(pr(1:k));
    end
    low_range=[0 high_range(1:length(pr)-1)];
    sbidx=zeros(size(seqin));
    for i=1:length(seqin)
        sbidx(i)=find(symbol==seqin(i));
    end
    high=1;low=0;
    for i=1:length(seqin)
        range=high-low;
        high=low+range*high_range(sbidx(i));
        low=low+range*low_range(sbidx(i));
    end
    arcode_low=low;
    arcode_high=high;

