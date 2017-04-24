//
//  MessageRuntime.h
//  YunGou
//
//  Created by bm on 16/12/29.
//  Copyright © 2016年 bangma. All rights reserved.
//

#import <Foundation/Foundation.h>
@class UIViewController;
@interface MessageRuntime : NSObject
-(void)receiveRemoteNotificationuserInfo:(NSDictionary *)userInfo needLoginView:(void (^)(BOOL needlogin , UIViewController * viewController))receive;
@end
