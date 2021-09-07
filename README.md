# 大学学习代码

> My bullshit written when I am a college student studing Automation.

这是我学习自动化专业期间写的一些代码。可以在[xsro.github.io/university-learning-code/](https://xsro.github.io/university-learning-code/)中预览大部分代码。

大概是从大三上学期开始，我尝试使用GIT来管理我的程序代码文件，后来我也把一些以前写的代码找了出来补充到这个仓库中。
由于我菜，时间有限，实验数据不足，需求不明等原因，示例代码使用的MATLAB版本不同等原因，代码中可能存在许多问题。
不过我重新整理了其中的大部分代码，并尽量使用MATLAB Live script和ipyhthon notebook来呈现效果，
应该bug会减少许多，并且更加美观吧。

由于整理大多是在期末复习时间做的。难免会有错误，欢迎反馈，提issue和PR。

## 文件结构

文件夹以数字加课程名称命名，可能不完全准确，很大一部分代码是简单的实验数据处理，可能不具有参考价值。

## 转换为html

1. 在MATLAB中调用 `convert.m` 来
   1. 调用[genMainPage.js](convert/genMainPage.js)生成`index.html`并生成matlab任务
   2. 调用[mlx2html.m](convert/mlx2html.m)，将matlab实时脚本mlx转化为html
   3. 使用`gh-pages`发布到github-pages
2. 可以使用浏览器打开 `public/index.html` 预览
