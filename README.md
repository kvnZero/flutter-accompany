# Flutter-accompany

## 最新动态
### 该项目更新速度会较慢
> 写的太乱啦所有就不继续写啦, 但是有很多值得参考的和已经完成的内容


### 已经完成的功能
> 注册 / 登录 / 找回密码功能写法

> 主页的类似闲鱼卡片式的组件和布局

> 社区页面

> 在线聊天 / 本地化数据存储 / 登录后保存token后续打开直接读取

> 安卓的闪屏过渡处理和样式处理

> 后端用的thinkphp6+mysql+swoole 仅用于增删改查的处理 一般自己编译存储使用是可以的。

## 运行方式
- 安装好thinkphp-swoole(不支持windows)将app/ExceptionHandle.php里替换swoole原有的Handle代码
- 在server打开终端运行 ``` php think run ``` 再启动一个终端运行``` php think swoole ```
- 修改所有本地地址(192.168.1.5:8000)修改成你的服务(注意不要使用localhost｜127.0.0.1)
- 运行启动您的应用
```dart
  flutter packages get
  flutter run
```

## 开发和调试环境
用的是Mac自带的ios模拟器(Iphone 11 Pro Max)开发;

## 新手文档参考

### [Flutter Go](https://github.com/alibaba/flutter-go/)

## 如果有其他问题,可联系交流
abigeater@163.com
