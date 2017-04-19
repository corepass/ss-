//
//  NSString+Extension.m
//  MJExtensionExample
//
//  Created by MJ Lee on 15/6/7.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>
@implementation NSString (Extension)
- (NSString *)underlineFromCamel
{
    if (self.length == 0) return self;
    NSMutableString *string = [NSMutableString string];
    for (NSUInteger i = 0; i<self.length; i++) {
        unichar c = [self characterAtIndex:i];
        NSString *cString = [NSString stringWithFormat:@"%c", c];
        NSString *cStringLower = [cString lowercaseString];
        if ([cString isEqualToString:cStringLower]) {
            [string appendString:cStringLower];
        } else {
            [string appendString:@"_"];
            [string appendString:cStringLower];
        }
    }
    return string;
}

+(BOOL)isprefNumber:(NSString *)NumStr{
    if ([NumStr hasPrefix:@"0"]) {
        return YES;
    }else if ([NumStr hasPrefix:@"1"]) {
        return YES;
    }else if ([NumStr hasPrefix:@"2"]) {
        return YES;
    }else if ([NumStr hasPrefix:@"3"]) {
        return YES;
    }else if ([NumStr hasPrefix:@"4"]) {
        return YES;
    }else if ([NumStr hasPrefix:@"5"]) {
        return YES;
    }else if ([NumStr hasPrefix:@"6"]) {
        return YES;
    }else if ([NumStr hasPrefix:@"7"]) {
        return YES;
    }else if ([NumStr hasPrefix:@"8"]) {
        return YES;
    }else if ([NumStr hasPrefix:@"9"]) {
        return YES;
    }
    return NO;
}

- (NSString *)camelFromUnderline
{
    if (self.length == 0) return self;
    NSMutableString *string = [NSMutableString string];
    NSArray *cmps = [self componentsSeparatedByString:@"_"];
    for (NSUInteger i = 0; i<cmps.count; i++) {
        NSString *cmp = cmps[i];
        if (i && cmp.length) {
            [string appendString:[NSString stringWithFormat:@"%c", [cmp characterAtIndex:0]].uppercaseString];
            if (cmp.length >= 2) [string appendString:[cmp substringFromIndex:1]];
        } else {
            [string appendString:cmp];
        }
    }
    return string;
}

- (NSString *)firstCharLower
{
    if (self.length == 0) return self;
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"%c", [self characterAtIndex:0]].lowercaseString];
    if (self.length >= 2) [string appendString:[self substringFromIndex:1]];
    return string;
}

- (NSString *)firstCharUpper
{
    if (self.length == 0) return self;
    NSMutableString *string = [NSMutableString string];
    [string appendString:[NSString stringWithFormat:@"%c", [self characterAtIndex:0]].uppercaseString];
    if (self.length >= 2) [string appendString:[self substringFromIndex:1]];
    return string;
}


- (id)JSONObject
{
    return [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
   
}


//  获取字符串的大小  ios7
+ (CGSize)getStringRect:(NSString*)aString withFont:(UIFont *)font{
    CGSize size = [aString boundingRectWithSize:CGSizeMake(MAXFLOAT, 21) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
    return  size;
}

#pragma mark - 渲染字体颜色
+ (NSMutableAttributedString*)renderText:(NSString *)text targetStr:(NSString *)tagStr font:(UIFont *)font andColor:(UIColor *)color{
    
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:text];
    //获得范围
    NSRange range = [text rangeOfString:tagStr];
    //设置颜色
    [attriString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(range.location, tagStr.length)];
    //设置字体
    [attriString addAttribute:NSFontAttributeName value:font range:NSMakeRange(range.location, range.length)];
    
    return attriString;
}


- (NSString *)MD5Hash
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}
+(NSString*)dataMD5:(NSData*)data
{
    CC_MD5_CTX md5;
    
    CC_MD5_Init(&md5);
    
    CC_MD5_Update(&md5, [data bytes], (CC_LONG)[data length]);
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString* s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0], digest[1],
                   digest[2], digest[3],
                   digest[4], digest[5],
                   digest[6], digest[7],
                   digest[8], digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    return s;
}
+(NSString*)fileMD5:(NSString*)path
{
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
    if( handle== nil ) return @"ERROR GETTING FILE MD5"; // file didnt exist
    
    CC_MD5_CTX md5;
    
    CC_MD5_Init(&md5);
    
    BOOL done = NO;
    while(!done)
    {
        NSData* fileData = [handle readDataOfLength: 10240];
        CC_MD5_Update(&md5, [fileData bytes], (CC_LONG)[fileData length]);
        if( [fileData length] == 0 ) done = YES;
    }
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    NSString* s = [NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                   digest[0], digest[1],
                   digest[2], digest[3],
                   digest[4], digest[5],
                   digest[6], digest[7],
                   digest[8], digest[9],
                   digest[10], digest[11],
                   digest[12], digest[13],
                   digest[14], digest[15]];
    return s;
}


- (NSInteger)fileSize
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 判断是否为文件
    BOOL dir = NO;
    BOOL exists = [mgr fileExistsAtPath:self isDirectory:&dir];
    // 文件\文件夹不存在
    if (exists == NO) return 0;
    
    if (dir) { // self是一个文件夹
        // 遍历caches里面的所有内容 --- 直接和间接内容
        NSArray *subpaths = [mgr subpathsAtPath:self];
        NSInteger totalByteSize = 0;
        for (NSString *subpath in subpaths) {
            // 获得全路径
            NSString *fullSubpath = [self stringByAppendingPathComponent:subpath];
            // 判断是否为文件
            BOOL dir = NO;
            [mgr fileExistsAtPath:fullSubpath isDirectory:&dir];
            if (dir == NO) { // 文件
                totalByteSize += [[mgr attributesOfItemAtPath:fullSubpath error:nil][NSFileSize] integerValue];
            }
        }
        return totalByteSize;
    } else { // self是一个文件
        return [[mgr attributesOfItemAtPath:self error:nil][NSFileSize] integerValue];
    }
}


+(NSString *)decimalWithString:(float)decimal{
    NSString *priceStr = [NSString stringWithFormat:@"%.2f",decimal];
    NSRange range = [priceStr rangeOfString:@"."];
    NSArray *newArr =  [priceStr componentsSeparatedByString:@"."];
    if ([newArr[1] isEqualToString:@"0"]) {
        return [priceStr substringToIndex:range.location];
    }else{
        return [NSString stringWithFormat:@"%.2f",decimal];
    }
}



+ (BOOL)checkTelNumber:(NSString *) telNumber{
    NSString *pattern = @"^1+[3578]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:telNumber];
}

+(BOOL)checkUserName:(NSString *)userName{
    NSString *pattern = @"^[\u4E00-\u9FA5]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:userName];
}

+(BOOL)checkAddress:(NSString *)address{
    NSString *pattern = @"[a-zA-Z\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:address];
}

+(BOOL)checkEmail:(NSString *)email{
    NSString *pattern = @"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:email];
}

+ (BOOL)checkPassword:(NSString *)password{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)(?![!#$@%^&*~_+-=?/,.;:]+$)[a-zA-Z0-9!#$@%^&*~_+-=?/,.;:]{6,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:password];
}



+(NSString *)hiddenPhoneNum:(NSString *)number{
    NSMutableString *mobileStr = [NSMutableString stringWithString:number];
    NSRange range = NSMakeRange(3, 4);
    return [mobileStr stringByReplacingCharactersInRange:range withString:@"****"];
}


- (NSArray *)words{
    
    NSMutableArray *words = [[NSMutableArray alloc] init];
    
    const char *str = [self cStringUsingEncoding:NSUTF8StringEncoding];
    
    char *word;
    for (int i = 0; i < strlen(str);) {
        int len = 0;
        if (str[i] >= 0xFFFFFFFC) {
            len = 6;
        } else if (str[i] >= 0xFFFFFFF8) {
            len = 5;
        } else if (str[i] >= 0xFFFFFFF0) {
            len = 4;
        } else if (str[i] >= 0xFFFFFFE0) {
            len = 3;
        } else if (str[i] >= 0xFFFFFFC0) {
            len = 2;
        } else if (str[i] >= 0x00) {
            len = 1;
        }
        
        word = malloc(sizeof(char) * (len + 1));
        for (int j = 0; j < len; j++) {
            word[j] = str[j + i];
        }
        word[len] = '\0';
        i = i + len;
        
        NSString *oneWord = [NSString stringWithCString:word encoding:NSUTF8StringEncoding];
        free(word);
        [words addObject:oneWord];
    }
    
    return words;
}

@end
