//
//  NSString+isEmpty.h
//  YunGou
//
//  Created by x on 16/6/13.
//  Copyright © 2016年 bangma. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (isEmpty)
/**
 *  判断字符串是否为空、nil
 *
 *  @param string string
 *
 *  @return bool
 */
+(BOOL)stringisEmpty:(NSString *)string;
/**
 *  判断字符串是手机号码
 *
 *  @param mobileNumbel string
 *
 *  @return bool
 */
+ (BOOL) isMobile:(NSString *)mobileNumbel;
/**
 *  判断字符串是否为空、nil
 *
 *  @param string string
 *
 *  @return 空返回0   原字符串
 */
/**
 *  判断是数字
 *
 *  @param string
 *
 *  @return return
 */
+(BOOL)stringisnumber:(NSString *)string;
+(NSInteger)stringprocessingdata:(NSString *)string;
+(NSString *)tranfromTime:(long long)ts;
+(NSString *)tranfromTimeddHHmmss:(long long)ts;
+(NSString *)tranfromTimeyyyyMMddHHmm:(long long)ts;
+(NSString *)tranfromTimeMMdd:(long long)ts;
/**
 *  自定义返回时间
 *  yyyy-MM-dd HH:mm:ss
 *  @param dateFormatter return 的时间格式
 *  @param times         时间
 *
 *  @return
 */
+(NSString *)tranfromTime:(NSString *)dateFormatter time:(long long)times;
@end
