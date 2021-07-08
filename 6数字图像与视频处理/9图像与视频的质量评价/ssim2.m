function [ mssim, ssim_map] = ssim2( refimg, testimg)
% ssim2 卢官明 《数字图像与视频处理》中提供的代码
% 使用OCR识别加人眼手动确认
% !!无法保证正确
    [M N] = size( refimg);
    refimg = double( refimg) ;
    testimg = double( testimg) ;
    K1 = 0.01;
    K2 = 0.03;
    L = 255;
    C1 = (K1*L)^2;
    C2 = (K2*L)^2;
    window = fspecial( 'gaussian', 11, 1.5);
    factor = max(1 ,round(min(M,N)/256));
    if( factor>1)
        lpf = ones( factor,factor) ;
        lpf = lpf/sum(lpf(:));
        refimg = imfilter( refimg,lpf,'symmetric', 'same');
        testimg = imfilter( testimg,lpf,'symmetric', 'same');
        refimg = refimg(   1:factor:end, 1:factor:end);
        testimg = testimg( 1:factor:end, 1:factor:end);
    end
    window = window/ sum(window(:));
    mu_ref = filter2( window, refimg, 'valid');
    mu_test= filter2( window, testimg, 'valid');
    mu_ref_sq = mu_ref .* mu_ref;
    mu_test_sq = mu_test .* mu_test;
    mu_ref_test = mu_ref .* mu_test;
    sigma_ref_sq = filter2( window, refimg .* refimg,'valid') - mu_ref_sq;
    sigma_test_sq = filter2( window, testimg.* testimg,'valid') - mu_test_sq;
    sigma_ref_test = filter2( window, refimg * testimg,'valid') - mu_ref_test;
    ssim_map = ((2*mu_ref_test + C1).*(2* sigma_ref_test + C2)) ...
        ./((mu_ref_sq + mu_test_sq+ C1).*(sigma_ref_sq + sigma_test_sq + C2));
    mssim = mean2( ssim_map);
end

