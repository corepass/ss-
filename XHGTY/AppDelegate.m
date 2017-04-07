//
//  AppDelegate.m
//  XHGTY
//
//  Created by 杨健 on 2016/11/15.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "AppDelegate.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "ThirdSDKDefine.h"
#import <CoreLocation/CoreLocation.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WebViewController.h"
#import "WXApi.h"
#import "HttpTools.h"
#import "UMessage.h"
#import "SVProgressHUD.h"
// 引入JPush功能所需头文件
#import "AppModel.h"
#import "JPUSHService.h"
#import "XHLaunchAd.h"
#import "LaunchAdModel.h"
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif


static NSString *appKey = @"dcd205f49eadbac179b60c1e";
static NSString *channel = @"App Store";


@interface AppDelegate ()<JPUSHRegisterDelegate,AMapLocationManagerDelegate,UNUserNotificationCenterDelegate>

@property (nonatomic,strong)UIStoryboard *story;
@property (nonatomic,strong)AMapLocationManager *locationManager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions {
    [[UINavigationBar appearance] setBarTintColor:[[UIColor alloc] initWithRed:237/255.0 green:31/255.0 blue:65/255.0 alpha:1]];
    [self shareSDKInterGration];

    application.statusBarHidden = NO;
    

    [[UITabBar appearance]setTintColor:[UIColor redColor]];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    if ([AppModel setJinShaVc]){
    [self viewAddView];
    }
    
    [self setXh];
    
    [UMessage startWithAppkey:@"58e1f28c734be464900013e2" launchOptions:launchOptions httpsEnable:YES ];
    [UMessage openDebugMode:YES];

    //注册通知
    [UMessage registerForRemoteNotifications];
    //iOS10必须加下面这段代码。
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate=self;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10 completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            
        } else {
            //点击不允许
            
        }
    }];
    
    //
    //Required添加初始化APNs代码
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [application setApplicationIconBadgeNumber:0];
    
    // Optional添加初始化JPush代码
    [JPUSHService setupWithOption:launchOptions appKey:appKey channel:channel apsForProduction:NO];
    [self savadata];
    return  YES;
}
-(void)savadata{
  //  let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
   //                                                FileManager.SearchPathDomainMask.userDomainMask,true).first!
  //  let userAccountPath = "\(path)/userAccount.data"
    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0]stringByAppendingFormat:@"/Caches"];
    NSString * file = [NSString stringWithFormat:@"%@/userAccount.data",path];
    
    NSArray * array = @[@{@"type":@"新加坡28",@"qishu":@"2698094",@"price":@"20",@"status":@"未中奖"},@{@"type":@"新加坡28",@"qishu":@"2698092",@"price":@"10",@"status":@"未中奖"},@{@"type":@"新加坡28",@"qishu":@"2698091",@"price":@"16",@"status":@"已中奖"},@{@"type":@"新加坡28",@"qishu":@"2698089",@"price":@"22",@"status":@"未中奖"},@{@"type":@"新加坡28",@"qishu":@"2698088",@"price":@"30",@"status":@"已中奖"},@{@"type":@"新加坡28",@"qishu":@"2698030",@"price":@"50",@"status":@"已中奖"}];
    if(![NSArray arrayWithContentsOfFile:file]){
      [array writeToFile:file atomically:YES];
    }
  

}
-(void)setXh{
    //1.因为数据请求是异步的,请在数据请求前,调用下面方法配置数据等待时间.
    //2.设为3即表示:启动页将停留3s等待服务器返回广告数据,3s内等到广告数据,将正常显示广告,否则将自动进入window的RootVC
    //3.数据获取成功,初始化广告时,自动结束等待,显示广告
    [XHLaunchAd setWaitDataDuration:3];//请求广告数据前,必须设置
    
    //广告数据请求
    [HttpTools getImaegWithPath:@"" parms:@{} success:^(id JSON) {
        LaunchAdModel *model = [[LaunchAdModel alloc] initWithDict:JSON[@"data"]];
        //配置广告数据
        XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
        //广告停留时间
        imageAdconfiguration.duration = model.duration;
        //广告frame
        imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
        imageAdconfiguration.imageNameOrURLString = model.content;
        //缓存机制(仅对网络图片有效)
        imageAdconfiguration.imageOption = XHLaunchAdImageDefault;
        //图片填充模式
        imageAdconfiguration.contentMode = UIViewContentModeScaleToFill;
        //广告点击打开链接
        imageAdconfiguration.openURLString = model.openUrl;
        //广告显示完成动画
        imageAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
        //跳过按钮类型
        imageAdconfiguration.skipButtonType = SkipTypeTimeText;
        //后台返回时,是否显示广告
        imageAdconfiguration.showEnterForeground = NO;
        
        //图片已缓存 - 显示一个 "已预载" 视图 (可选)
        if([XHLaunchAd checkImageInCacheWithURL:[NSURL URLWithString:model.content]])
        {
            //设置要添加的自定义视图(可选)
       //     imageAdconfiguration.subViews = [self launchAdSubViews_alreadyView];
            
        }
        //显示开屏广告
        [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
        

    } :^(NSError *error) {
        
    }];

    


}

/**
 *  广告点击事件 回调
 */
- (void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenURLString:(NSString *)openURLString;
{
    
 /*   NSLog(@"广告点击");
    WebViewController *VC = [[WebViewController alloc] init];
    VC.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",openURLString]];
    [self.window.rootViewController presentViewController:VC animated:YES completion:nil];
  */
    
}
-(void)viewAddView{
  
  
        [HttpTools getWithPathsuccess:^(id JSON) {
            dispatch_async(dispatch_get_main_queue(), ^{
                WebViewController * web = [[WebViewController alloc]init];
                web.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",JSON]];
                if(![self.window.rootViewController isKindOfClass:[WebViewController class]]){
                    self.window.rootViewController = web;
                    [self.window makeKeyAndVisible];
                }
          
//                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",JSON]]];
            });
        } :^(NSError *error) {
            
        }];

}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    return YES;
}


- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSLog(@"token = %@",deviceToken);
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    NSLog(@"UserInfo = %@",userInfo);
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}




- (void)applicationDidBecomeActive:(UIApplication *)application{
    [application setApplicationIconBadgeNumber:0];
}




- (void)shareSDKInterGration{
    
    [ShareSDK registerApp:kMobAppKey activePlatforms:@[@(SSDKPlatformTypeWechat), @(SSDKPlatformTypeQQ)] onImport:^(SSDKPlatformType platformType) {
        switch (platformType){
          
            case SSDKPlatformTypeWechat:
                [ShareSDKConnector connectWeChat:[WXApi class]];
                break;
            case SSDKPlatformTypeQQ:
                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                break;
            default:
                break;
        }
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        switch (platformType)
        {
            case SSDKPlatformTypeWechat:
                [appInfo SSDKSetupWeChatByAppId:kWeiXinAppID appSecret:kWeiXinAppSecret];
                break;
            case SSDKPlatformTypeQQ:
                [appInfo SSDKSetupQQByAppId:kQQAppID appKey:kQQAppKey authType:SSDKAuthTypeSSO];
                break;
            default:
                break;
        }
    }];
}


//NSDate -----> NSString
- (NSString *)getFormatDateStringWithDate:(NSDate *)date  withFormatStyle:(NSString *)dateFormatStyle
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormatStyle];
    
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

-(NSString *)timeStrTotimestamp:(NSString*)timeStr withFormat:(NSString *)format{
    
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    //[inputFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [inputFormatter setDateFormat:format];
    NSDate* inputDate = [inputFormatter dateFromString:timeStr];
    
    NSString *timeStamp = [NSString stringWithFormat:@"%ld",(long)[inputDate timeIntervalSince1970]];
    return timeStamp;
}

@end
