//
//  FXRecord.h
//  NewPuJing
//
//  Created by 杨健 on 2016/12/7.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXRecord : NSObject

@property (nonatomic,copy)NSString *longdate;
@property (nonatomic,copy)NSString *shortperiod;

@property (nonatomic,strong)NSMutableArray *totalBords;

@end
