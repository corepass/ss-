//
//  FXAccount.h
//  NewPuJing
//
//  Created by 杨健 on 2016/12/6.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXAccount : NSObject<NSCoding>
/** 用户uid */
@property (nonatomic,copy) NSString *uid;
/** 手机 */
@property (nonatomic,copy) NSString *mobile;
/** 密码 */
@property (nonatomic,copy) NSString *password;
@property (nonatomic,copy)NSString *userName;
@property (nonatomic,copy)NSString *avatar;
/** 临时uid */
@property (nonatomic,copy)NSString * tmp_uid;
@end
