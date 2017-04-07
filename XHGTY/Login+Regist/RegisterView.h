//
//  RegisterView.h
//  YunGou
//
//  Created by x on 16/5/25.
//  Copyright © 2016年 bangma. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface RegisterView : UIView
-(id)initWithFrame:(CGRect)frame andDataArray:(NSArray *)Array;
/**
 *  Account ：账号
 *  Captcha ：验证码
 *  Invitationsystem ：邀请码
 *  SetupPassWord ：设置密码
 *  ConfirmPassWord ：确认密码
 */
@property(copy,nonatomic) void (^RegistBlock) (NSString * Account,NSString * Captcha,NSString * Invitationsystem,NSString * SetupPassWord,NSString * ConfirmPassWord);
/**
 *  Account：账号
 */
@property(copy,nonatomic) void(^CaptchaBlock) (NSString * Account,UIButton * button);
@property(copy,nonatomic) void(^sendalertView)(NSString * title);
@property(copy,nonatomic) void(^loginqqblock)(BOOL isqq , BOOL iswx);
@property(copy,nonatomic) void(^aboutqmdb)(void);
@end
