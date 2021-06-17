dst="public";
mlxs = dir('**/*.mlx');
N=length(mlxs);
fprintf("[start]convert %d mlx from %s/ to %s/\n",N,pwd,dst);
folder=strcat(pwd,'/',dst);
%make sure destination folder exist
if exist(folder,'dir')==7
else
    mkdir(folder);
end
%Convert Matlab live script to html.follow the instruction from:
%https://www.mathworks.com/matlabcentral/answers/282820-programmatically-run-and-export-live-script#comment_1457761
htmls=repmat("",1,N);
mlxsref=repmat("",1,N);
for i=1:N
    mlx=mlxs(i);
    mlxloc=strcat(mlx.folder,'/',mlx.name);
    mlxsref(i)=strrep(mlxloc,pwd,"");
    name=strcat('m',num2str(i),'.html');
    fileout = strcat(folder,'/',name);
    htmls(i)=name;
    fileout=convertStringsToChars(fileout);
    matlab.internal.liveeditor.openAndConvert(mlxloc,fileout);
    fprintf("%3d: converted %s\tfrom %s\n",i,name,mlxsref(i));
end
%sort files
[mlxsref,idx]=sort(mlxsref);
htmls=htmls(idx);


%write index.html
indexFile=strcat(dst,'/index.html');
fid=fopen(indexFile,'w');
head='<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />';
fprintf(fid,"<head>\n%s\n</head>\n<body><h1>MATLAB Live Scripts Collection</h1>\n",head);
description="<details><summary>info</summary>\n"+...
    "Thanks to my lovely teachers,classmates,BanBan and NJUPT's MATLAB license.This is our code when studing Auto.We can make NO WARRANTY<br>"+...
    "这是我整理的我们的大三学习过程中的一些代码，在整理过程中，我花费了很多的时间，但是其中难免还会有很多的错误，整理过程中我也得到了很多的帮助，欢迎进行PR<br>"+...
    "<a href='https://gitee.com/xsro/university-learning-code'><img src='https://gitee.com/xsro/university-learning-code/widgets/widget_6.svg' alt='Fork me on Gitee'></img></a>\n"+...
    "</details>";
fprintf(fid, description);
subtitle="";
for i=1:length(htmls)
    html=htmls(i);
    mlxref=mlxsref(i);
    segs=split(mlxref,'/');
    name=join(segs(3:end),'/');
    url='./'+html;
    if segs(2)~=subtitle
        if i~=1
            fprintf(fid,"</ol>\n");
        end
        subtitle=segs(2);
        fprintf(fid,"<h2>%s</h2>\n<ol>\n",subtitle);       
    end
    nb="";
    nbref=strrep(mlxref,'.mlx','.ipynb');
    if exist(pwd+nbref,'file')
        link="https://gitee.com/xsro/university-learning-code/tree/develop/"+nbref;
        nb=sprintf(" , <a href='%s'>ipynb</a>", link);
    end
    fprintf(fid,"<li>%s: <a href='%s'>mlx</a>%s</li>\n",strrep(name,'.mlx',''),url,nb);
end
fprintf(fid,"%s",'</ol>');
fprintf(fid,"%s",'</body>');
fclose(fid);
