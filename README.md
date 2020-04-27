# Swift5 + MVVM + 文艺复兴微博(纯代码)

<br>

背景: 现在越来越多的公司会尝试用 Swift 做 native 的开发了，很多之前习惯用 Objective-C 的开发，有新项目启动的时候，也会想说用 Swift 试试。如果从 [2020年编程语言排行榜](https://hellogithub.com/report/tiobe/) 上看的话，Swift的热度也领先 Objective-C 10个身位了。而我们现在公司所做的项目，也是用 Swift 开发的，虽然说之前有些 OC 基础，写起 Swift 功能也是能实现，但是代码不是很优雅，不够 'Swift Style'。 熟练度不够的话，很多 Swift 的高级写法还得去翻文档才知道什么意思，所以就打算从0单排一个Swift的项目，而微博正好有 [开放API](https://open.weibo.com/) , 所以这里就选择它了。


<br>


## 主页界面

![](https://github.com/miniLV/github_images_miniLV/blob/master/juejin/171bb13d7c6e6265?raw=true)



<br>

## 表情界面
![](https://github.com/miniLV/github_images_miniLV/blob/master/juejin/171bb1441ef0b8bf?raw=true)
<br>



## 项目架构

![](https://github.com/miniLV/github_images_miniLV/blob/master/juejin/171b713959fc32de?raw=true)



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



## 不足点

- Weibo 的 App 包里的素材图片实在太多了，找到完全匹配的要花费超多时间，所以有的资源不是很匹配，或者不是当前最新的
- 该Demo使用了FMDB，其实微博这种时效性毕竟高，且有较高政治敏感度的，不适合用本地缓存, 这里只是一个 FMDB 使用的简单案例，更适合更新不用太及时，或者类似qq这种接收服务端推送消息的app.
- 这个文艺复兴版的微博(2016年的)，现在的微博已经有了较大的变动，且很多API接口现在已经不开放了，所以暂时先用此怀旧版本.
- SVProgressHUD 在Swift5.0会crash，所以这个app里没有 toast 功能，坐等修复...
- Gif图片由于现在门户网站只能传 < 5M 的，所以看上去毕竟模糊，实际效果会比 Gif 图片好得多，建议用真机跑一下试试~
- 这版本来打算用本人拙劣的英文写全篇的注释，后来由于本人 Chinelish 水平有限，毕竟复杂的逻辑/业务就用中文写了(*求轻喷*)
- ...



## 使用的第三方库

- AFNetworking
- SDWebImage
- YYModel
- SnapKit
- FMDB
- pop
- HMPhotoViewerController



## 工具分享

图片素材获取: [cartool](https://github.com/steventroughtonsmith/cartool)

取色标注工具: [MarkMan](http://www.getmarkman.com/)

数据库工具: [Navicat](https://www.navicat.com.cn/)

画图工具: [MindNode](https://mindnode.com/)

...



<br>

## 总结

从事了一段时间的 Swift 开发，发现没有一定量的代码积淀(踩坑)还是不行，所以就打算自己写一个入门的纯Swift App。这个项目是本萌新的第一个发布swift项目，有些粗糙，但是如果新手作为 Swift 上手，入门的，其实应该还可以。该项目基本都是用的 “纯代码+纯Swift” 的方式写的，用的也是尽量新的 API, 萌新们想玩的话感觉还是可以上手的。



最近发现，**时间管理** 真的很重要，很多事情，一开始以为自己做不到，就打退堂鼓了，但是只要咬咬牙，挑战一下自己的极限，这不，这个Demo就出来了~ (为了写这破玩意，老夫都颈椎病去做针灸了，骗波 star不过分吧~ (开玩笑的，大家开心就好😂))


*觉得哪里写的不好的，哪里能改进的，有时间帮忙做code review，提PR的，热烈欢迎啊，这里先谢过了~*

<br>

---

本文Demo：[MNWeibo](https://github.com/miniLV/MNWeibo)



<br>



*本文感谢 新浪提供的 [API](https://open.weibo.com/) 支持，感谢 [天涯刀哥-傅红雪](https://github.com/liufan321) 的指导*
