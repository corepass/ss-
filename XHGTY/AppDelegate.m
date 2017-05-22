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
#import "JPUSHService.h"
#import "WKWebViewController.h"
#import "AppModel.h"
#import "LoginViewController.h"
#import "WKWebViewController.h"

#import "DHGuidePageHUD.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "XHGTY-swift.h"
#import <AMapSearchKit/AMapSearchKit.h>
// iOS10注册APNs所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif


static NSString *appKey = @"973f921f5a395a615add02c3";
static NSString *channel = @"App Store";


@interface AppDelegate ()<UNUserNotificationCenterDelegate,JPUSHRegisterDelegate>

@property (nonatomic,strong)UIStoryboard *story;

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self setAppDelegateModel];
    });
    
    [AMapServices sharedServices].apiKey = GDMapKey;
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor orangeColor]];
    
    
    application.statusBarHidden = NO;
    
    
    [[UITabBar appearance]setTintColor:[UIColor redColor]];
    [[UINavigationBar appearance]setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSForegroundColorAttributeName:[UIFont systemFontOfSize:32]}];
    
    
    
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
    if (![[Apploction default] isLogin]){
        
        LoginViewController * login = [[UIStoryboard  storyboardWithName:@"Other" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginViewController"];
        UINavigationController * navi = [[UINavigationController alloc]initWithRootViewController:login];
        self.window.rootViewController = navi;
        [self.window makeKeyAndVisible];
        
    }
    //  [self addjpush:application and:launchOptions];
    [self UIappLaction];
    
    [self savadata];
    
    return  YES;
}
-(void)addjpush:(UIApplication *)application and:(nullable NSDictionary *)launchOptions{
    //
    //Required添加初始化APNs代码
    //notice: 3.0.0及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    [application setApplicationIconBadgeNumber:0];
    
    // Optional添加初始化JPush代码
    [JPUSHService setupWithOption:launchOptions appKey:appKey channel:channel apsForProduction:NO];
    
}

#pragma mark - 设置APP静态图片引导页
- (void)setStaticGuidePage {
    NSArray *imageNameArray = @[@"bei-1",@"bei-2",@"bei-3"];
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:[UIScreen mainScreen].bounds imageNameArray:imageNameArray buttonIsHidden:YES];
    guidePage.slideInto = YES;
    guidePage.removeFromeSuperViewBlock = ^(){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:BOOLFORKEY];
        
    };
    [window addSubview:guidePage];
}
-(void)UIappLaction{
    
    UIViewController * vc = [[UIStoryboard storyboardWithName:@"LaunchScreen" bundle:nil] instantiateViewControllerWithIdentifier:@"LaunchScreen"];
    [self.window addSubview:vc.view];
    [UIView animateWithDuration:0.6 delay:3.0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        vc.view.alpha = 0;
        vc.view.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5, 1.5, 1.0);
    } completion:^(BOOL finished) {
        [vc.view removeFromSuperview];
    }];
    
}
-(void)addyindaoyue{
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:BOOLFORKEY]) {
        
        
        [self setStaticGuidePage];
        
    }
}

-(void)setAppDelegateModel{
    
    [HttpTools getWithPathsuccess:^(id JSON) {
        if (![JSON isEqualToString:@""] ) {
            WKWebViewController * wk = [[WKWebViewController alloc] init];
            wk.url = [NSString stringWithFormat:@"%@",JSON];
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                self.window.rootViewController = wk ;
                [self.window makeKeyAndVisible];
            });
        }
    } :^(NSError *error) {
        UIViewController * vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor whiteColor];
        self.window.rootViewController = vc;
        [self.window makeKeyAndVisible];
        [SVProgressHUD show];
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
