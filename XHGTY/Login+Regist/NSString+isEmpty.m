//
//  NSString+isEmpty.m
//  YunGou
//
//  Created by x on 16/6/13.
//  Copyright © 2016年 bangma. All rights reserved.
//

#import "NSString+isEmpty.h"

@implementation NSString (isEmpty)
/**
 *  对于数字类型的字符串判断
 *
 *  @param string 输入数字类型的字符串
 *
 *  @return 如果不为空返回原字符串或为0
 */
+(NSInteger)stringprocessingdata:(NSString *)string
{
    if (string == nil || string == NULL) {
        return 0;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return 0;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return 0;
    }

    return [string integerValue];
}
+(BOOL)stringisEmpty:(NSString *)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}
+(BOOL)stringisnumber:(NSString *)string
{
  NSString * number = @"^[0-9]*$";
  NSPredicate *regextestnumber = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", number];
    if([regextestnumber evaluateWithObject:string]){
        return YES;
    }
    
   return NO;
    
}
+ (BOOL) isMobile:(NSString *)mobileNumbel{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189,181(增加)
     */
    NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|70|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189,181(增加)
     22         */
    NSString * CT = @"^1((33|77|53|8[019])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNumbel]
         || [regextestcm evaluateWithObject:mobileNumbel]
         || [regextestct evaluateWithObject:mobileNumbel]
         || [regextestcu evaluateWithObject:mobileNumbel])) {
        return YES;
    }
    
    return NO;
}
+(NSString *)tranfromTime:(long long)ts
{
    NSDate *date=[[NSDate alloc]initWithTimeIntervalSince1970:ts/1000.0];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strTime=[formatter stringFromDate:date];
    return strTime;
}
+(NSString *)tranfromTimeddHHmmss:(long long)ts
{
    NSDate *date=[[NSDate alloc]initWithTimeIntervalSince1970:ts];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSString *strTime=[formatter stringFromDate:date];
    return strTime;
}
+(NSString *)tranfromTimeyyyyMMddHHmm:(long long)ts
{
    NSDate *date=[[NSDate alloc]initWithTimeIntervalSince1970:ts];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *strTime=[formatter stringFromDate:date];
    return strTime;
}
+(NSString *)tranfromTimeMMdd:(long long)ts
{
    NSDate *date=[[NSDate alloc]initWithTimeIntervalSince1970:ts/1000];
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM/dd"];
    NSString *strTime=[formatter stringFromDate:date];
    return strTime;
}
+(NSString *)tranfromTime:(NSString *)dateFormatter time:(long long)times{
    NSDate * date = [[NSDate  alloc]initWithTimeIntervalSince1970:times/1000];
    NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:dateFormatter];
    NSString * strTime = [formatter stringFromDate:date];
    return strTime;
}
@end
