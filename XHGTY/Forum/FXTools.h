//
//  FXTools.h
//  NewHuangguan
//
//  Created by 杨健 on 2017/4/6.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXTools : NSObject
+(NSString *)toolsWithName:(NSString *)name;
+(void)showSuccessMsg:(NSString *)message;
+(void)showErrorMsg:(NSString *)message;
@end
