![iPush](https://github.com/hushihua/cableUi/blob/master/cableUi.png)

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

###  2.添加项目设置

#### 1.主项目添加 Push Notifications 功能
在```Targets```中选择主项，点击右则 ```Signing & Capabilities```， 点击 ```+ ```，选择``` Push Notifications```选项。

#### 2. Enable Bitcode 设置成 NO

#### 3. 添加以下权限描述
```
<key>NSCameraUsageDescription</key>
<string>此App会在用户扫描二维码信息时访问您的相机, 使用过程为用户保密</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>发送具体位置给好友时，需要用到位置服务，使用过程安全保密</string>
<key>NSLocationUsageDescription</key>
<string>发送具体位置给好友时，需要用到位置服务，使用过程安全保密</string>
<key>NSLocationWhenInUseUsageDescription</key>
<string>发送具体位置给好友时，需要用到位置服务，使用过程安全保密</string>
<key>NSMicrophoneUsageDescription</key>
<string>此App会在用户语音聊天时访问您的麦克风,然后打包提交, 使用过程为用户保密</string>
<key>NSPhotoLibraryAddUsageDescription</key>
<string>此App会为用户保存图片到您的相册,此过程不会有数据泄露, 使用过程为用户保密</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>此App会在用户使用照片时访问您的相册,然后打包提交, 使用过程为用户保密</string>
```

## 三：代码流程接入

### 1.在 AppDelegate.m 文件中引入 iPush，并初始化（以Swift项目为例）。
```
import iPush

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    //选择运行环境 
    //true:测试环境，false:正式环境(默认)
    IMuiApi.getInstance().DEBUG = true    
    //初始化sdk
    IMuiApi.getInstance().initSdk()  
    //申请获取 deviceToken
    PushApi.getInstance().registerNotification(application: application, delegate: self)    
    //生成register_id
    PushApi.getInstance().registerUID { (response:PHResponse<String>) in                    
        print("*** [SDK] \(response.data ?? "")")
    }
    return true
}
```
### 2. 实现推送回调方法
当收到apns推送时，将回调```UNUserNotificationCenterDelegate```代理方法参考如下(原生apns消息回调代理方法)。如要支持ios 10以下的系统，请自行补充版本兼容代码。
```
func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    PushApi.getInstance().pushToken(data:deviceToken) { (response:PHResponse<Bool>) in
    }
}

@available(iOS 10.0, *)
func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){
    PushApi.getInstance().userNotificationCenter(center, willPresent:notification, completionHandler:completionHandler)
    completionHandler([.alert, .sound])
}

@available(iOS 10.0, *)
func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void){
    PushApi.getInstance().userNotificationCenter(center, didReceive:response)
    completionHandler()
}

func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    PushApi.getInstance().application(application, didReceiveRemoteNotification:userInfo)
    completionHandler(UIBackgroundFetchResult.newData)
}
```

## 四. 运行Demo注意事项

### 1. pod install
下载demo项目后，打开主目录，在终端中执行 pod install。

### 2. 替换你的 appkey
打开项目，打开 AppDelegate文件，在 initSDK 方法中替换成你申请成功的appkey

注意： 测试环境下的appkey，与正式环境下的appkey不相同，请分开申请。
