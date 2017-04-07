//
//  FXPeiLv.h
//  +
//
//  Created by 杨健 on 2017/1/3.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXPeiLv : NSObject

@property (nonatomic,copy)NSString *leagueName;
@property (nonatomic,copy)NSString *matchCode;
@property (nonatomic,copy)NSString *matchTime;
@property (nonatomic,copy)NSString *hostName;
@property (nonatomic,copy)NSString *visitName;

@property (nonatomic,strong)NSArray *ouOdds;

@end
