function [htmls,mlxsref]=convert(dst)
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
    fprintf(fid,"\nThis is our code when studing Auto.Thanks very much to my lovely teachers,classmates and BanBan. We can make no NO WARRANTY\n");
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
        fprintf(fid,"<li><a href='%s'>%s</a></li>\n",url,name);
    end
    fprintf(fid,"%s",'</ol>');
    fprintf(fid,"%s",'</body>');
    fclose(fid);
end