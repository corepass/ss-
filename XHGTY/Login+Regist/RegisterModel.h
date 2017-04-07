//
//  RegisterModel.h
//  YunGou
//
//  Created by x on 16/5/26.
//  Copyright © 2016年 bangma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterModel : NSObject
/**
 *  账号
 */
@property(copy,nonatomic) NSString * Account;
/**
 *  验证码
 */
@property(copy,nonatomic) NSString * Captcha;
/**
 *  邀请码
 */
@property(copy,nonatomic) NSString * Invitationsystem;
/**
 *  密码
 */
@property(copy,nonatomic) NSString * SetupPassWord;
/**
 *  再次输入密码
 */
@property(copy,nonatomic) NSString * ConfirmPassWord;
@property(strong,nonatomic) NSString * Title;
@property(copy,nonatomic) NSMutableDictionary * paramDic;
@property(copy,nonatomic) void(^WarnTitleBlock)(NSString * Title);
@end
