//
//  NotificationModel.m
//  YunGou
//
//  Created by x on 16/6/2.
//  Copyright © 2016年 bangma. All rights reserved.
//

#import "NotificationModel.h"
#define W_mainsize [UIScreen mainScreen].bounds.size.width
@implementation NotificationModel

-(void)setSubLable:(NSString *)SubLable
{
    _SubLable = SubLable;
//    NSDate *date=[[NSDate alloc]initWithTimeIntervalSince1970:[_SubLable longLongValue]/1000];
//    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
//    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString *strTime=[formatter stringFromDate:date];
//    _SubLable = strTime;
}
@end
