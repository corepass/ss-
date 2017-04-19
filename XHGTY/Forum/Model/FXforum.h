//
//  FXforum.h
//  NewPuJing
//
//  Created by 杨健 on 2016/12/7.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "BaseObject.h"

@interface FXforum : BaseObject
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *content;
@property (nonatomic,copy)NSString *create_time;
@property (nonatomic,copy)NSString *avatar;
@property (nonatomic,copy)NSString *user_nicename;
@property (nonatomic,copy)NSString *add_time;
@property (nonatomic,copy)NSString *user_id;

@end
