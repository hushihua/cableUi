![iPush](https://github.com/hushihua/iMui/blob/master/cableUi.png)

[![CI Status](https://img.shields.io/travis/adam/cableUi.svg?style=flat)](https://travis-ci.org/adam/cableUii)
[![Version](https://img.shields.io/cocoapods/v/cableUi.svg?style=flat)](https://cocoapods.org/pods/cableUi)
[![License](https://img.shields.io/cocoapods/l/cableUi.svg?style=flat)](https://cocoapods.org/pods/cableUi)
[![Platform](https://img.shields.io/cocoapods/p/cableUi.svg?style=flat)](https://cocoapods.org/pods/cableUi)


## 一：开设帐号，生成appkey

联系工作人员，提供 boundId，测试环境apns证书，正式环境apns证书，生成 appkey。

##  二：集成SDK

### 1.CocoaPods 集成

iPush支持 CocoaPods 方式和手动集成两种方式。我们推荐使用 CocoaPods 方式集成，以便随时更新至最新版本。

在 Podfile 中增加以下内容。
```
 pod 'cableUi'
```
执行以下命令，安装 iPush。
```
 pod install
```
如果无法安装 SDK 最新版本，执行以下命令更新本地的 CocoaPods 仓库列表。
```
 pod repo update
```

### 2.主项目添加 Push Notifications 功能
在```Targets```中选择主项，点击右则 ```Signing & Capabilities```， 点击 ```+ ```，选择``` Push Notifications```选项。


