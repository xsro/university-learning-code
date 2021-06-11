function convert(dst)
    %Convert Matlab live script to html.follow the instruction from:
    %https://www.mathworks.com/matlabcentral/answers/282820-programmatically-run-and-export-live-script#comment_1457761
    dirInfo = dir('**/*.mlx');
    N=length(dirInfo);
    fprintf("[start]convert %d mlx to %s\n",N,dst);
    htmls=repmat("",1,N);

    for i=1:N
        mlx=dirInfo(i);
        mlxloc=strcat(mlx.folder,'/',mlx.name);
        name=strrep(mlx.name,'mlx','html');
        folder=insertAfter(mlx.folder,'university-learning-code/',strcat(dst,'/'));
        if exist(folder,'dir')==7
        else
            mkdir(folder);
        end
        fileout = strcat(folder,'/',name);
        htmls(i)=fileout;
        fileout=convertStringsToChars(fileout);
        matlab.internal.liveeditor.openAndConvert(mlxloc,fileout);
        fprintf("%d:converted %s\n",i,mlxloc);
    end

    htmls=sort(htmls);
    indexFile=strcat(dst,'/index.html');
    fid=fopen(indexFile,'w');
    head='<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />';
    fprintf(fid,"<head>\n%s\n</head>\n<body>\n<ol>",head);
    for i=1:length(htmls)
        ref=strrep(htmls(i),strcat(pwd,'/',dst,'/'),"");
        url='./'+ref;
        fprintf(fid,"<li><a href='%s'>%s</a></li>\n",url,ref);
    end
    fprintf(fid,"%s",'</ol>');
    fprintf(fid,"%s",'</body>');
end