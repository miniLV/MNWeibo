# Swift5 + MVVM + 文艺复兴微博(纯代码)

<br>

## 项目架构

![](https://github.com/miniLV/github_images_miniLV/blob/master/juejin/171b713959fc32de?raw=true)

<br>

## 主页界面

![](https://github.com/miniLV/github_images_miniLV/blob/master/juejin/171bb13d7c6e6265?raw=true)



<br>

## 表情界面
![](https://github.com/miniLV/github_images_miniLV/blob/master/juejin/171bb1441ef0b8bf?raw=true)
<br>



## 项目功能


- [x] 原创微博功能
- [x] 转发微博功能
- [x] Emoji表情功能
- [x] 撰写微博界面
- [x] 新特性功能
- [x] 消息提醒功能
- [x] 多图展示功能
- [x] 富文本功能
- [x] 多图展示功能
- [x] 下滑自动加载功能
- [x] 上/下拉刷新功能
- [x] OAuth 授权登录功能
- [x] 已完成
- [ ] 发布微博功能(API已不提供)
- [ ] 图片上传功能(API已不提供)
- [ ] 消息功能
- [ ] 发现功能
- [ ] 我的功能
- [ ]  SVProgressHUD 提醒功能



<br>

## 用到的技术点

- TableView高度缓存
- SDWebImage圆角处理
- FMDB数据缓存
- OAuth授权
- 单张图片的高度计算
- Cell滚动自动加载更多
- 撰写页面的动画处理
- 发布界面的Emoji处理
- 多图的展示
- ...

<br>

## 使用的第三方库

- AFNetworking
- SDWebImage
- YYModel
- SnapKit
- FMDB
- pop
- HMPhotoViewerController

<br>

## 下期优化
- 使用 Swift 版的字典转模型,使用Codable 替换 YYModel
- 使用 Swift 的网络请求库, 替换 `AFNnetworking`
- 更加 Swift~
- ...

<br>

## 工具分享

图片素材获取: [cartool](https://github.com/steventroughtonsmith/cartool)

取色标注工具: [MarkMan](http://www.getmarkman.com/)

数据库工具: [Navicat](https://www.navicat.com.cn/)

画图工具: [MindNode](https://mindnode.com/)

...



<br>

## 使用说明 

*Weibo Api 更新，原本的三种登录方法现在均无法使用，需使用WeiboSDK.（已更新）*

**可行方案:** 使用准备好的Weibo账号登录.

账号: 13580587848

密码: gxt11629


**方案一:**  ~~使用App 里面的“自动填充”功能，里面有准备好的测试账号了~~(已废弃)


**方案二:**  ~~使用固定的 `access_token`~~(已废弃)

1. 登录微博, 进入开发微博开发平台 https://open.weibo.com/apps/new?sort=mobile 创建一个app应用，平台选iPhone
2. https://open.weibo.com/tools/console 获取 Access Token，替换项目里面的 `access_token` 的返回值即可



**方案三:**  ~~使用用户账号/密码在微博门户网站登录(OAuth授权)~~(已废弃)

1. 登录微博, 进入开发微博开发平台 https://open.weibo.com/apps/new?sort=mobile 创建一个app应用，平台选iPhone
2. 在 “应用信息里”，获取该 App 的 `App key` & `App Secret` , 分别替换项目里的 `MNAppKey`  & `MNAppSecret`

![image-20200428150543679](https://tva1.sinaimg.cn/large/007S8ZIlgy1ge9hvgzkmjj312n0u04c6.jpg)

3. 设置 OAuth 授权页面的授权回调页

![WX20200428-145508@2x](https://tva1.sinaimg.cn/large/007S8ZIlgy1ge9hzshox4j31na0gi0zo.jpg)




---

背景&总结：[MSwift5 + MVVM + 文艺复兴微博(纯代码)](https://juejin.im/post/5ea5a5d051882573883be60a)



<br>



*本文感谢 新浪提供的 [API](https://open.weibo.com/) 支持，感谢 [天涯刀哥-傅红雪](https://github.com/liufan321) 的指导*
