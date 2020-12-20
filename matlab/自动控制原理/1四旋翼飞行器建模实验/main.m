outCon=[2 0 0;3 0 0;2 0 0];
inCon=[1 0 0.03;1 0 0.03;1 0.2 0.03];
[~,sheets] = xlsfinfo('data.xlsx');
num=xlsread('data.xlsx', 'WLP' );
writedata(outCon,inCon,num)
num=xlsread('data.xlsx', 'LBC2' );
writedata(outCon,inCon,num)