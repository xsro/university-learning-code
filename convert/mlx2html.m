%Convert Matlab live script to html.follow the instruction from:
%https://www.mathworks.com/matlabcentral/answers/282820-programmatically-run-and-export-live-script#comment_1457761
cd ..
cd public
text=fileread('matlab_task.txt');
text=strsplit(text,'\n');
for i=1:length(text)
    line=strtrim(text{i});
    line=strsplit(line,'\t');
    if length(line)==2
        src=line{1};
        dst=line{2};
        if ~exist('dry_run_convert')
            matlab.internal.liveeditor.openAndConvert(src,dst);
        end
    end
end
cd ..


