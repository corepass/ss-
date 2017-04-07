//
//  ThirdLoginself.m
//  YunGou
//
//  Created by x on 16/6/18.
//  Copyright © 2016年 bangma. All rights reserved.
//

#import "ThirdLoginModel.h"
#import "NSString+isEmpty.h"

@implementation ThirdLoginModel
-(id)init{
    if( self = [super init]){
    _param = [[NSMutableDictionary alloc]init];
    }
    return self;
}
-(void)setNickname:(NSString *)nickname
{
    _nickname = nickname;
    if (![NSString stringisEmpty:_nickname]) {
        [_param setObject:_nickname forKey:@"nickname"];
    }
 }

-(void)setOpenid:(NSString *)openid
{
    _openid = openid;
    if (![NSString stringisEmpty:_openid]) {
        [_param setObject:_openid forKey:@"openId"];
    }

}
-(void)setRawData:(NSDictionary *)rawData
{        _rawData = rawData;
    if (_rawData) {
        
        ![NSString stringisEmpty:_rawData[@"city"]]?[_param setObject:_rawData[@"city"] forKey:@"city"]:nil;
        ![NSString stringisEmpty:_rawData[@"figureurl"]]?[_param setObject:_rawData[@"figureurl_qq_1"] forKey:@"headimgurl"]:nil;
        ![NSString stringisEmpty:_rawData[@"province"]]?[_param setObject:_rawData[@"province"] forKey:@"province"]:nil;
        ![NSString stringisEmpty:_rawData[@"city"]]?[_param setObject:_openid forKey:@"openId"]:nil;


    }

}

-(void)setDeviceToken:(NSString *)deviceToken
{
    _deviceToken = deviceToken;
    if (_deviceToken) {
        [_param setObject:[NSString stringWithFormat:@"%@",_deviceToken] forKey:@"deviceToken"];
    }

}

@end
