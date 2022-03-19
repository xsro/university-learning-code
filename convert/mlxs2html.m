function mlxs2html(taskFile,dry_run_convert)
    text=fileread(taskFile);
    text=strsplit(text,'\n');
    for i=1:length(text)
        line=strtrim(text{i});
        line=strsplit(line,'\t');
        if length(line)==2
            src=line{1};
            dst=line{2};
            
            if dry_run_convert
                fprintf("dry-run")
            else
                try
                    if exist('export','file')
                        fprintf("%d: export %s-->%s",i,src,dst)
                        export(src,dst,CatchError=false,HideCode=false);
                    else
                        fprintf("%d: openAndConvert %s-->%s",i,src,dst)
                        matlab.internal.liveeditor.openAndConvert(src,dst);
                    end
                catch err 
                    disp(err.identifier);
                    disp(err.message);
                    disp(err.stack);
                end
            end
            fprintf("\n")
        end
    end
end


