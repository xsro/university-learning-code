% ��������������Ӻ���
% th_mean: ��ֵ����
% I:����ͼ��
% Yout: ���ͼ��
function Yout = regiongrow(I,seed,th_mean)
    [M,N]=size(I);
    L=size(seed,1);
    Yout=zeros(M,N);
    sum =zeros(1,L);
    for i=1:L
        Yout(seed(i,1),seed(i,2))=1;
    end
    for i=1:L
        sum(i)=I(seed(i,1),seed(i,2));
    end
    seed_mean=mean(sum);
    ok=true;
    s_star=1;
    s_end=L;
    while ok
        ok=false;
        %�������Ӷ����У�ѡ�����������
        for i=s_star:s_end
            x=seed(i,1);
            y=seed(i,2);
            %�߽������
            if x>2 && (x+1)<M && y>2 && (y+1)<N
            %�ж����ӵ�8����
                for u=-1:1
                    for v=-1:1
                        %�����Ϊ����
                        %���ж��Ƿ���Ҫ���кϲ�������������ϲ�������
                        if Yout(x+u,y+v)==0 && abs(I(x+u,y+v)-seed_mean)<=th_mean
                            Yout(x+u,y+v)=1;
                            ok=true;
                            seed=[seed;[x+u y+v]];
                        end
                    end
                end
            end
        end
    s_star=s_end+1;
    L=size(seed,1);
    s_end =L;
    end
end