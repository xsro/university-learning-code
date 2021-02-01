imaqhwinfo

obj = videoinput('winvideo');

set(obj,'FramesPerTrigger', 1);

set(obj,'TriggerRepeat',Inf);

%定义一个监控界面

hf = figure('Units', 'Normalized', 'Menubar', 'None','NumberTitle', 'off', 'Name', '实时拍照系统');

ha = axes('Parent', hf, 'Units', 'Normalized', 'Position', [0.05 0.2 0.85 0.7]);

axis off

%定义两个按钮控件

hb1 = uicontrol('Parent', hf, 'Units', 'Normalized','Position', [0.25 0.05 0.2 0.1], 'String', '预览', 'Callback', ['objRes = get(obj, "VideoResolution");''nBands = get(obj, "NumberOfBands");' 'hImage = image(zeros(objRes(2), objRes(1), nBands));' 'preview(obj, hImage);']);

hb2 = uicontrol('Parent', hf, 'Units', 'Normalized','Position', [0.55 0.05 0.2 0.1], 'String', '拍照', 'Callback','imwrite(getsnapshot(obj),im.jpg)');


