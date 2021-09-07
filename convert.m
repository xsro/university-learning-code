if exist('public','dir')
    if ismac
        !rm -rf public
    elseif isunix
        !rm -rf public
    elseif ispc
        !del /F /S /Q public
    else
        disp('Platform not supported,try do with matlab')
        delete public/*.*
        rmdir public/
    end
end

mkdir public

fprintf('node: generate task and index.html\n')
if ismac
    !zsh -l -c 'node convert/genMainPage.js'
elseif isunix
    !bash -l -c 'node convert/genMainPage.js'
elseif ispc
    !node convert/genMainPage.js
else
    disp('Platform not supported')
end

fprintf("matlab: convert all mlx to html\n");
cd convert
mlx2html
cd public
delete matlab_task.txt
cd ..

if exist('deploy','var')
    fprintf("node: deploy folder public/ to web\n")
    if ismac
        !zsh -l -c 'npm run deploy'
    elseif isunix
        !bash -l -c 'npm run deploy'
    elseif ispc
        !npm run deploy
    else
        disp('Platform not supported')
    end
end