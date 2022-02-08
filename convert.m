fprintf('node: generate convert task and index.html\n')
if ismac
    !zsh -l -c 'node .\convert\  gen'
elseif isunix
    !bash -l -c 'node .\convert\  gen'
elseif ispc
    !node .\convert\  gen
else
    disp('Platform not supported')
end

fprintf("matlab: convert all mlx to html\n");
addpath convert
task='convert/public/matlab_task.txt';
mlxs2html(task,0)
delete(task)

if exist('deploy','var')
    fprintf("node: add ga to html and deploy folder public/ to web\n")
    if ismac
        !zsh -l -c 'node .\convert\ ga deploy'
    elseif isunix
        !bash -l -c 'node .\convert\ ga deploy'
    elseif ispc
        !node .\convert\ ga deploy
    else
        disp('Platform not supported')
    end
end