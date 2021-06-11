function convert(dst)
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
        %Convert Matlab live script to html.follow the instruction from:
        %https://www.mathworks.com/matlabcentral/answers/282820-programmatically-run-and-export-live-script#comment_1457761
        matlab.internal.liveeditor.openAndConvert(mlxloc,fileout);
        fprintf("%d:converted %s\n",i,mlxloc);
    end

    htmls=sort(htmls);
    indexFile=strcat(dst,'/index.html');
    fid=fopen(indexFile,'w');
    head='<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />';
    fprintf(fid,"<head>\n%s\n</head>\n<body><h1>my MATLAB Live Script Collection</h1>\n",head);
    subtitle="";
    for i=1:length(htmls)
        html=htmls(i);
        ref=strrep(html,strcat(pwd,'/',dst,'/'),"");
        url='./'+ref;
        segs=split(ref,'/');
        if segs(1)~=subtitle
            if i~=1
                fprintf(fid,"</ol>\n");
            end
            fprintf(fid,"<h2>%s</h2>\n<ol>\n",segs(1));
            subtitle=segs(1);
        end
        fprintf(fid,"<li><a href='%s'>%s</a></li>\n",url,join(segs(2:end),'/'));
    end
    fprintf(fid,"%s",'</ol>');
    fprintf(fid,"%s",'</body>');
end