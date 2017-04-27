//
//  AppModel.m
//  bjscpk10
//
//  Created by shensu on 17/3/26.
//  Copyright © 2017年 shensu. All rights reserved.
//

#import "AppModel.h"

@implementation AppModel
+ (BOOL)setJinShaVc
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-yyyy-HHmmss"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    NSDate *date = [formatter dateFromString:dateTime];

    //2016-09-30-00
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy-HHmmss"];
    NSDate *dateDangQian = [dateFormatter dateFromString:ssoptime];

    NSComparisonResult result = [date compare:dateDangQian];
    
    if(result == 1){
        return YES;
    }
    return NO;
    
    
}

+ ( NSString *)pinJieStr
{
    NSMutableArray *arr0 = [NSMutableArray arrayWithObjects:@"d;a#", @"*",@"lqsp", @"htt", @"p:", @"//", @"www.", @"946",@".tv", @"/app", @"/index", @".php?", @"APPLE_API", @"=", @"URL", @"&&", @"ID", ssID, @"qwe", @"loi", @"wda", nil];
    NSString *allStr = [NSString stringWithFormat:@""];
    
    for (NSInteger i = 3; i < arr0.count - 3; i++) {

        NSString *allStrA = [NSString stringWithFormat:@"%@", arr0[i]];
        
        if (i == 0) {
            allStr = allStrA;
            
        }else {
            allStr  = [allStr stringByAppendingString:allStrA];
        }
        
    }
    
    
    return allStr;
}


@end
