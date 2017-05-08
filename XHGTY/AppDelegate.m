//
//  AppDelegate.m
//  XHGTY
//
//  Created by 杨健 on 2016/11/15.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "AppDelegate.h"



#import <AMapFoundationKit/AMapFoundationKit.h>

#import "MessageRuntime.h"
#import "WebViewController.h"

#import "HttpTools.h"
#import "UMessage.h"
#import "SVProgressHUD.h"


#import "AppModel.h"

#import "WKWebViewController.h"

#import "DHGuidePageHUD.h"
#import <AMapFoundationKit/AMapFoundationKit.h>

#import <AMapSearchKit/AMapSearchKit.h>
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif


static NSString *appKey = @"dcd205f49eadbac179b60c1e";
static NSString *channel = @"App Store";


@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@property (nonatomic,strong)UIStoryboard *story;

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions {
    if ([AppModel setJinShaVc]){
        [self setAppDelegateModel];
    }
    
   [AMapServices sharedServices].apiKey = GDMapKey;
    
    [[UINavigationBar appearance] setBarTintColor:[[UIColor alloc] initWithRed:237/255.0 green:31/255.0 blue:65/255.0 alpha:1]];

 
    application.statusBarHidden = NO;
    

    [[UITabBar appearance]setTintColor:[UIColor redColor]];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSForegroundColorAttributeName:[UIFont systemFontOfSize:32]}];
    
    
 //   [self setXh];
    
    [UMessage startWithAppkey:UMKey launchOptions:launchOptions httpsEnable:YES ];
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
    
   

    [self savadata];

    return  YES;
}
-(void)setAppDelegateModel{
    [HttpTools getWithPathsuccess:^(id JSON) {
                    NSLog(@"有活动的时候开启");
                MessageRuntime * message  =  [[MessageRuntime alloc] init];
                [message receiveRemoteNotificationuserInfo:JSON needLoginView:^(BOOL needlogin, UIViewController *viewController) {
                    self.window.rootViewController = viewController;
                    [self.window makeKeyAndVisible];
                }];
        
        } :^(NSError *error) {
               
    }];

}
-(void)savadata{

    
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0]stringByAppendingFormat:@"/Caches"];
    NSString * file = [NSString stringWithFormat:@"%@/userAccount.shouchang",path];
    if(![NSArray arrayWithContentsOfFile:file]){
    NSArray * arrary = @[@{@"time":@"2017-04-05",@"haoma":@[@"03",@"04",@"10",@"15",@"21",@"31",@"07"],@"qishu":@"2017041",@"kjtime":@"04-02 21:30"}];
      [arrary writeToFile:file atomically:YES];
    }
  

}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 
    return YES;
}


- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    NSLog(@"token = %@",deviceToken);
    /// Required - 注册 DeviceToken

}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}


#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
//    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {

    }
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    NSLog(@"UserInfo = %@",userInfo);
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {

    }
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support

    completionHandler(UIBackgroundFetchResultNewData);
}




- (void)applicationDidBecomeActive:(UIApplication *)application{
  
    [application setApplicationIconBadgeNumber:0];
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
