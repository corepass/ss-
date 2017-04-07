//
//  AppDefine.h
//  CityCook
//
//  Created by yang on 16/2/20.
//  Copyright © 2016年 Sichuan City Cooking Brother. All rights reserved.
//

#ifndef AppDefine_h
#define AppDefine_h

#if (DEBUG || TESTCASE)
#define FxLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
#define FxLog(format, ...)
#endif

#define FxLogFunc FxLog(@"%s",__func__)

// 日志输出宏
#define BASE_LOG(cls,sel) FxLog(@"%@-%@",NSStringFromClass(cls), NSStringFromSelector(sel))
#define BASE_ERROR_LOG(cls,sel,error) FxLog(@"ERROR:%@-%@-%@",NSStringFromClass(cls), NSStringFromSelector(sel), error)
#define BASE_INFO_LOG(cls,sel,info) FxLog(@"INFO:%@-%@-%@",NSStringFromClass(cls), NSStringFromSelector(sel), info)

// 日志输出函数
#if (DEBUG || TESTCASE)
#define BASE_LOG_FUN()         BASE_LOG([self class], _cmd)
#define BASE_ERROR_FUN(error)  BASE_ERROR_LOG([self class],_cmd,error)
#define BASE_INFO_FUN(info)    BASE_INFO_LOG([self class],_cmd,info)
#else
#define BASE_LOG_FUN()
#define BASE_ERROR_FUN(error)
#define BASE_INFO_FUN(info)
#endif

// 设备类型判断
#define kIsiPad     (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define kIsiPhone   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define kIsRetain   ([[UIScreen mainScreen] scale] >= 2.0)
#define kIsiPhone4   (kIsiPhone && kScreenMaxLength < 568.0)
#define kIsiPhone5   (kIsiPhone && kScreenMaxLength == 568.0)
#define kIsiPhone6   (kIsiPhone && kScreenMaxLength == 667.0)
#define kIsiPhone6P  (kIsiPhone && kScreenMaxLength == 736.0)

//判断设备宽高
#define kScreenW ([[UIScreen mainScreen] bounds].size.width)
#define kScreenH ([[UIScreen mainScreen] bounds].size.height)

#define kScreenCenterX kScreenW * 0.5

#define kScreenSize [UIScreen mainScreen].bounds.size

#define kScreenCenter CGPointMake(kScreenW * 0.5, kScreenH*0.5);

#define kScreenMaxLength (MAX(kScreenW, kScreenH))
#define kScreenMinLength (MIN(kScreenW, kScreenH))

// 消息通知
#define kRegisterNotify(_name, _selector) [[NSNotificationCenter defaultCenter] addObserver:self selector:_selector name:_name object:nil];
#define kRremoveNofify [[NSNotificationCenter defaultCenter] removeObserver:self];
#define kSendNotify(_name, _object) [[NSNotificationCenter defaultCenter] postNotificationName:_name object:_object];

// 设置颜色值
#define kColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define kRandomColor kColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256),1)

#define kGlobalColor kColor(242,242,242,1)

//设置字体
#define kFont(F) [UIFont systemFontOfSize:(F)]
#define kBoldFont(F) [UIFont boldSystemFontOfSize:F]

//获取版本信息
#define kAppVersion [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]

//获取设备相关
#define kSystemVersion [[UIDevice currentDevice] systemVersion]
#define kDeviceIdentifier [[[UIDevice currentDevice] identifierForVendor]UUIDString]
#define kDeviceModel [[UIDevice currentDevice]model]
#define kDeviceName [[UIDevice currentDevice]name]

//获取APP代理
#define kAppDelegate (AppDelegate *)[[UIApplication sharedApplication] delegate]

//获取App应用
#define kAppLication [UIApplication sharedApplication]

//获取窗口
#define kAppWindow [UIApplication sharedApplication].keyWindow

//获取窗口尺寸
#define kScreenBounds [UIScreen mainScreen].bounds

//获取设备id
#define kAppDeviceID [[[UIDevice currentDevice] identifierForVendor] UUIDString]

//获取文件路径
#define kFilePathName(name) [[NSBundle mainBundle]pathForResource:name ofType:nil]

//获取图片
#define kImageName(name)  [UIImage imageNamed:name]

//得到URL
#define kUrlStr(urlStr) [NSURL URLWithString:urlStr]

//打开某个app
#define kOpenURLStr(urlStr) [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlStr]]

//判断能否打开某个app
#define kCaneOpenURLStr(openURl) [[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:openURl]]
 
//创建button
#define kCustomButton [UIButton buttonWithType:UIButtonTypeCustom]

//保存账户信息
#define kAccountFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

//获取帐户信息
#define kAccount [FXUserTool sharedFXUserTool].account


//保存商品信息
#define kShopFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"shops.data"]

//缓存路径
#define kCachePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"cache.data"]

//数据库路径
#define kDataBasePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"searchGoods.sqlite"]

// 占位图
#define kPlaceImage [UIImage imageNamed:@"zhanweitu"]

//价格
#define kPrice(name) [NSString stringWithFormat:@"¥%@",name]

//单利
#define kSingleton [[FXSingleton alloc]init]

//系统字典
#define kUserDefault [NSUserDefaults standardUserDefaults]


//密码提示
#define kPasswordTips @"1:密码设置6-20位,由字母,数字和符号的两种以上组合,安全性最高\n2:不允许空格、特殊字符,如 <>'\(){}[]。允许的符号为:!#$@%^&*~_+-=?/,.;:\n3:不要使用纯数字密码,这样容易被人猜到\n4:不要使用太多连续或重复的字符(如:1234、abcd、3333、 ssss等)\n5:不要用手机号、电话号码、生日、学号、身份证号等个人信息\n友情提醒:用户名和密码要做好相应记录,以免忘记"

#define kErrorPasswordTips @"设置密码格式错误，请输入6-20位,由字母,数字和符号的两种以上组合"

#define kNoNetWorking @"似乎已断开与互联网的连接"

#endif /* AppDefine_h */
