//
//  RegisterModel.m
//  YunGou
//
//  Created by x on 16/5/26.
//  Copyright © 2016年 bangma. All rights reserved.
//

#import "RegisterModel.h"
#import "NSString+isEmpty.h"
@implementation RegisterModel
-(void)setAccount:(NSString *)Account
{
    _Account = Account;
    _paramDic = [[NSMutableDictionary alloc]init];
    (_Account!=nil)? [_paramDic setObject:_Account forKey:@"mobile"]:nil;
}
-(void)setCaptcha:(NSString *)Captcha
{
    _Captcha = Captcha;
    (_Captcha!=nil)?[_paramDic setObject:_Captcha forKey:@"validCode"]:nil;
}
-(void)setInvitationsystem:(NSString *)Invitationsystem
{
    _Invitationsystem = Invitationsystem;
    (_Invitationsystem!=nil)?[_paramDic setObject:_Invitationsystem forKey:@"findCode"]:nil ;
}
-(void)setSetupPassWord:(NSString *)SetupPassWord
{
    _SetupPassWord = SetupPassWord;
    (_SetupPassWord!=nil)? [_paramDic setObject:_SetupPassWord forKey:@"password"]:nil ;
}
-(void)setConfirmPassWord:(NSString *)ConfirmPassWord
{
    _ConfirmPassWord = ConfirmPassWord;
    (_ConfirmPassWord!=nil)? [_paramDic setObject:_ConfirmPassWord forKey:@"rePassword"]:nil;
}
-(void)setWarnTitleBlock:(void (^)(NSString *))WarnTitleBlock
{_WarnTitleBlock = WarnTitleBlock;
    if (_WarnTitleBlock) {
        if (_Account==nil) {
            _WarnTitleBlock(@"请输入账户");
        }else if (![NSString isMobile:_Account]){
            _WarnTitleBlock(@"账号错误");
        }else if (_ConfirmPassWord ==nil){
            _WarnTitleBlock(@"请再次输入密码");
        }else if (![_SetupPassWord isEqualToString:_ConfirmPassWord]){
            _WarnTitleBlock(@"两次输入的密码不一致");
        }else
        {
            _WarnTitleBlock(@"");
        };
  
    }
}
@end
