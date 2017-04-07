//
//  LotteryKind.h
//  +
//
//  Created by 杨健 on 2017/1/3.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LotteryKind : NSObject

@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *qiShu;
@property (nonatomic,copy)NSString *time;
@property (nonatomic,strong)NSArray *redNumArray;
@property (nonatomic,strong)NSArray *blueNumArray;
@property (nonatomic ,strong) NSString * url;

@end
