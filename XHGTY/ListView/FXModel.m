//
//  FXModel.m
//  +
//
//  Created by shensu on 17/4/25.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "FXModel.h"
#import "NSString+isEmpty.h"
@implementation FXModel
-(NSMutableArray *)modelArray
{
    if (!_modelArray){
        _modelArray = [[NSMutableArray alloc] init];
        NSArray * numberArray = [self.opencode componentsSeparatedByString:@","];
        if(self.expect){
            [_modelArray addObject:self.expect];
        }else{
        [_modelArray addObject:@""];
        }
        if(numberArray){
            [_modelArray addObjectsFromArray:numberArray];
        }else{
           [_modelArray addObjectsFromArray:@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@""]];
        }
        if(self.opentimestamp){
        NSString * openTime = [NSString tranfromTimeyyyyMMddHHmm:[self.opentimestamp longLongValue] andType:@"HH:MM"];
            if(openTime){
            [_modelArray addObject:openTime];
            }else{
                [_modelArray addObject:@""];
            }
        
        }
    
    
    }

    return  _modelArray;
}
@end
