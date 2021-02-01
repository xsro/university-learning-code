n=100
for i=1:n-1
    if val(i)>=20 && val(i+1)-val(i)>0
        k=k+1;
    end
end
