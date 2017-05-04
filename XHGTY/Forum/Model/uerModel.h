//
//  uerModel.h
//  +
//
//  Created by shensu on 17/5/4.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface uerModel : NSObject
@property(copy,nonatomic) NSString * create_time;
@property(copy,nonatomic) NSString * device_id;
@property(copy,nonatomic) NSString * icon;
@property(copy,nonatomic) NSString * id;
@property(copy,nonatomic) NSString * name;
@property(copy,nonatomic) NSString * reg_ip;
@property(copy,nonatomic) NSString * v_tag;
@property(copy,nonatomic) NSString * vip;

@end
/*  
 "user": {
 "create_time": 1460619405000,
 "device_id": "None",
 "icon": "http://social.icaipiao123.com/static/icon/avatar.jpg",
 "id": 1,
 "name": "旺彩平台管理员",
 "reg_ip": "None",
 "v_tag": 1,
 "vip": {}
 },
 */
