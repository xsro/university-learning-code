imaqhwinfo

obj = videoinput('winvideo');

set(obj,'FramesPerTrigger', 1);

set(obj,'TriggerRepeat',Inf);

%����һ����ؽ���

hf = figure('Units', 'Normalized', 'Menubar', 'None','NumberTitle', 'off', 'Name', 'ʵʱ����ϵͳ');

ha = axes('Parent', hf, 'Units', 'Normalized', 'Position', [0.05 0.2 0.85 0.7]);

axis off

%����������ť�ؼ�

hb1 = uicontrol('Parent', hf, 'Units', 'Normalized','Position', [0.25 0.05 0.2 0.1], 'String', 'Ԥ��', 'Callback', ['objRes = get(obj, "VideoResolution");''nBands = get(obj, "NumberOfBands");' 'hImage = image(zeros(objRes(2), objRes(1), nBands));' 'preview(obj, hImage);']);

hb2 = uicontrol('Parent', hf, 'Units', 'Normalized','Position', [0.55 0.05 0.2 0.1], 'String', '����', 'Callback','imwrite(getsnapshot(obj),im.jpg)');


