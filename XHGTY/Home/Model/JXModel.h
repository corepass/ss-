//
//  JXModel.h
//  +
//
//  Created by shensu on 17/4/17.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JXModel : NSObject
@property(assign,nonatomic) int cpCount;
@property(assign,nonatomic) BOOL isblue;
-(NSArray *)getarc4random;
-(NSArray *)getarc4randoArcount:(int)sumCount classCount:(int)count frome:(int)from tonumber:(int)tofrom;
@end
