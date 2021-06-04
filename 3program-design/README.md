# 线上票务系统

这是我在程序设计周自己小组写的程序，虽然很粗糙但是，我还是决定把它整理出来。以供之后回忆那段难忘的日子。

## 运行方法

- 安装gcc或者其他工具
- 编译源程序`gcc main.cpp -o main.exe`
- 运行源程序`main.exe`

### 原来附带的说明

```
管理员密钥：NJUPT
VIP密钥：njupt
使用以上密钥可以注册VIP和管理员
使用用户名1密码1可以直接普通用户身份登陆
使用用户名2密码2可以直接管理员身份登陆
```

## 程序设计思路

```flow
st=>start: 开始
cond=>condition: 登陆模块 login()
是不是管理员
op=>operation: 查询 query()
e=>end
st->cond->op
cond(yes)->op1
cond(no)->op
```

``` mermaid
graph LR
A[开始] -->A1{登陆程序}
A1-->|普通用户|A2q{选择}
A1-->|管理员|A2w{选择}
A1-->|VIP|A2e[普通查询程序]
A2q-->|购票或仅查询|B1[查询]
B1-->B2(订票)
A2q-->|退改签|B3[查寻自己的订票记录]
```

