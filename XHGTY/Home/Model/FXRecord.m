//
//  FXRecord.m
//  NewPuJing
//
//  Created by 杨健 on 2016/12/7.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "FXRecord.h"

@implementation FXRecord

-(NSMutableArray *)totalBords{
    if (_totalBords == nil) {
        _totalBords = [NSMutableArray array];
    }
    return _totalBords;
}

@end
