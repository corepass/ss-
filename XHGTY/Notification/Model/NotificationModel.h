//
//  NotificationModel.h
//  YunGou
//
//  Created by x on 16/6/2.
//  Copyright © 2016年 bangma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>
@interface NotificationModel : NSObject
@property(copy,nonatomic) NSString * TitleLable ;
@property(copy,nonatomic) NSString * SubLable ;
@property(assign,nonatomic) BOOL isRead;
@property(copy,nonatomic) NSString * ID;
@property(copy,nonatomic) NSString * DetaLable ;
@property(copy,nonatomic) NSString * url;
@end
