//
//  NSString+Extension.h
//  MJExtensionExample
//
//  Created by MJ Lee on 15/6/7.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSString (Extension)
/**
 *  驼峰转下划线（loveYou -> love_you）
 */
- (NSString *)underlineFromCamel;
/**
 *  下划线转驼峰（love_you -> loveYou）
 */
- (NSString *)camelFromUnderline;
/**
 * 首字母变大写
 */
- (NSString *)firstCharUpper;
/**
 * 首字母变小写
 */

- (NSString *)firstCharLower;

//首字母是不是数字
+ (BOOL)isprefNumber:(NSString *)NumStr;

/**
 * 计算字符串矩形框
 */
+ (CGSize)getStringRect:(NSString *)aString withFont:(UIFont *)font;

/**
 * 渲染字符串
 */
+ (NSMutableAttributedString*)renderText:(NSString *)text targetStr:(NSString *)tagStr font:(UIFont *)font andColor:(UIColor *)color;

- (id)JSONObject;

- (NSString *)MD5Hash;

+(NSString*)fileMD5:(NSString*)path;

+(NSString*)dataMD5:(NSData*)data;

/**
 *  计算当前文件\文件夹的内容大小
 */
- (NSInteger)fileSize;

/**
 * 处理带小数点的字符串，如果以0结尾直接干掉，否则保留，只保留1位
 */

+ (NSString *)decimalWithString:(float)decimal;

- (NSArray *)words;

/**检查手机号码，用户名，地址，邮箱是否合法是否合法*/
+ (BOOL)checkTelNumber:(NSString *)telNumber;

+ (BOOL)checkUserName:(NSString *)userName;

+ (BOOL)checkAddress:(NSString *)address;

+ (BOOL)checkEmail:(NSString *)email;

+ (BOOL)checkPassword:(NSString *)password;

/**把手机号码中间几位隐藏*/
+ (NSString *)hiddenPhoneNum:(NSString *)number;


@end
