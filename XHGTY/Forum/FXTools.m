//
//  FXTools.m
//  NewHuangguan
//
//  Created by 杨健 on 2017/4/6.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "FXTools.h"

@implementation FXTools
+(NSString *)toolsWithName:(NSString *)name{
    if ([name isEqualToString:@"超级大乐透"]) {
        return @"4b114184f676a6b3edb088aaac1b4dbf";
    }else if([name isEqualToString:@"双色球"]){
        return @"c34b039a1144cf897abbdeb6aaab28f7";
    }else if ([name isEqualToString:@"福彩3D"]){
        return @"5fd125c452d8e79d0770479403e393c0";
    }else if ([name isEqualToString:@"老11选5"]){
        return @"80c2ab810f8c5c4a4e6d1176f397b5e4";
    }else if ([name isEqualToString:@"粤11选5"]){
        return @"d1373596947647b352cf2d49e668425e";
    }else if ([name isEqualToString:@"欢乐11选5"]){
        return @"13a1a4a031795584fc9a5b82ca90bc95";
    }else if ([name  isEqualToString:@"快乐扑克3"]){
        return @"539bbc30eb426fbf815b33cf4550f78f";
    }else if ([name  isEqualToString:@"快乐十分"]){
        return @"214ed02ddba9d06d78484ebfdbdc492a";
    }else if ([name  isEqualToString:@"快3"]){
        return @"6505a779262f10e3867ac379b53a1bdf";
    }else if ([name  isEqualToString:@"新快3"]){
        return @"724cd1a55e2788159c4daec819930eb3";
    }else if ([name  isEqualToString:@"京快三"]){
        return @"a2c9b9df3336b696beaa788ff5bcac42";
    }else if ([name isEqualToString:@"好运11选5"]){
        return @"eac4694c2952248507ed52c76b3409c5";
    }else if ([name isEqualToString:@"沪11选5"]){
        return @"6c85dd96f3502645a9a2269f270df2c0";
    }else if ([name isEqualToString:@"新11选5"]){
        return @"64b09e8c90221cd3e310641973ec530d";
    }else if ([name isEqualToString:@"老时时彩"]){
        return @"2654e06e9b48131c467c7bc71ec1e732";
    }else if ([name isEqualToString:@"七乐彩"]){
        return @"068510cf109fb6587a63fb732c94c5e7";
    }else if ([name isEqualToString:@"七星彩"]){
        return @"bf26c6b5abdb1c1e24436e39bfb9679c";
    }else if ([name isEqualToString:@"新群英会"]){
        return @"153db5bb1478c22fb185808464f2ebd9";
    }
    return nil;
}


+(void)showSuccessMsg:(NSString *)message  {
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    [SVProgressHUD showSuccessWithStatus:message];
}

+(void)showErrorMsg:(NSString *)message{
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    [SVProgressHUD showErrorWithStatus:message];
}
@end
