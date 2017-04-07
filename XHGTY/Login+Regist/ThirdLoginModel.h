//
//  ThirdLoginModel.h
//  YunGou
//
//  Created by x on 16/6/18.
//  Copyright © 2016年 bangma. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef NS_ENUM(NSUInteger, Gender){
//    /**
//     *  男
//     */
//    GenderMale      = 1,
//    /**
//     *  女
//     */
//    GenderFemale    = 0,
//    /**
//     *  未知
//     */
//    GenderUnknown   = 2,
//};
typedef NS_ENUM(NSInteger,PlatformType)
{
    phone = 0,
    qq = 1,
     wx = 2,
    
};
@interface ThirdLoginModel : NSObject
/**
 *  平台类型
 */
//@property (nonatomic) PlatformType platformType;
/**
 *  openid
 */
@property (nonatomic, copy) NSString * openid;
/**
 *  用户标识
 */
@property (nonatomic, copy) NSString *uid;
/**
 *  性别
 */
//@property (nonatomic) SSDKGender gender;
/**
 *  昵称
 */
@property (nonatomic, copy) NSString *nickname;

/**
 *  头像
 */
@property (nonatomic, copy) NSString *icon;

/**
 *  原始数据
 */
@property (nonatomic, retain) NSDictionary *rawData;

@property(nonatomic,retain) NSString * deviceToken;

@property (nonatomic, retain) NSMutableDictionary * param;

@end
