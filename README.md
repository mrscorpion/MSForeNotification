# MSForeNotification
iOS Foreground Push Notification, the same as the system style, both Banner and Sound

MSForeNotification

在 App 处于前台时展示跟系统完全一样的推送弹窗和声音。获取推送内容，并且处理点击事件。

支持 iOS 7~10 beta，支持模拟器和真机运行。

效果

跟系统推送弹窗 UI 效果完全相同
可以自动获取 App 的应用名称，应用图标
弹窗时会自动隐藏系统状态栏、收起后自动显示系统状态栏
自带推送声音
时间及下方收拉条的颜色跟当前页面的背景颜色相同
自带点击事件，点击可获取推送内容，进行相应页面跳转
自带上滑手势，快速收起
自动在处于最前端的 controller 上进行弹窗
：
![](screenshot02.gif)


手动 安装

下载并在 Xcode 中 拖拽拷贝 根目录中的 EBForeNotification 文件夹至 Xcode 工程。
targets --> Build Settings --> 搜 other link --> 添加 -ObjC。
![](install.png)
本地弹窗

在任意方法内调用以下任 1 行代码即可弹窗

#import "EBForeNotification.h"
{...
//普通弹窗(系统声音)
[EBForeNotification handleRemoteNotification:@{@"aps":@{@"alert":@"展示内容"}} soundID:1312];

//普通弹窗(指定声音文件)
[EBForeNotification handleRemoteNotification:@{@"aps":@{@"alert":@"展示内容"}} customSound:@"my_sound.wav"];

//带自定义参数的弹窗(系统声音)
[EBForeNotification handleRemoteNotification:@{@"aps":@{@"alert":@"展示内容"}, @"key1":@"value1", @"key2":@"value2"} soundID:1312];

//带自定义参数的弹窗(指定声音文件)
[EBForeNotification handleRemoteNotification:@{@"aps":@{@"alert":@"展示内容"}, @"key1":@"value1", @"key2":@"value2"} customSound:@"my_sound.wav"];
...}
接收远程/本地推送后弹窗

接收远程/本地推送后，自动在前台展示推送弹窗及声音。

在 AppDelegate.m 中添加代码

//AppDelegate.m
#import "EBForeNotification.h"

//ios7 before
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo { 
    ...
    //系统声音弹窗
    [EBForeNotification handleRemoteNotification:userInfo soundID:1312];

    //指定声音文件弹窗
    [EBForeNotification handleRemoteNotification:userInfo customSound:@"my_sound.wav"];
    ...
}

//ios7 later  
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {    
    ...
    //系统声音弹窗
    [EBForeNotification handleRemoteNotification:userInfo soundID:1312];

    //指定声音文件弹窗
    [EBForeNotification handleRemoteNotification:userInfo customSound:@"my_sound.wav"];
    ...
    completionHandler(UIBackgroundFetchResultNewData);
}
soundID 参数

iOS 系统自带的声音 id，系统级的推送服务默认使用的是三全音，id = 1312

其他系统声音 id 可以在这里查询到 iOS Predefined sounds 备用地址 AudioServices sounds

监听并处理点击事件

添加 Observer 监听 EBBannerViewDidClick，获取推送内容，通过推送时自定义的字段处理自己逻辑，如：跳转到对应页面等。

接收到的推送内容类似以下：

{
    "aps":
    {
        "alert":"推送内容",
        "sound":"sound",
        "badge":"3"
    },
        "key1":"跳转页面1"  //自定义此字段以跳转到相应页面
}
添加 Observer 获取自定义的字段，并处理：

#import "EBForeNotification.h"
[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(eBBannerViewDidClick:) name:EBBannerViewDidClick object:nil];
-(void)eBBannerViewDidClick:(NSNotification*)noti{
    if(noti[@"key1" == @"跳转页面1"]){
        //跳转到页面1
    }
}
