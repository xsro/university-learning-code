if exist('public','dir')
    delete public/*.*
    rmdir public/
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

if ~exist('nodeploy')
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