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
        [_modelArray addObjectsFromArray:@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""]];
        NSArray * numberArray = [self.opencode componentsSeparatedByString:@","];
        if(self.expect){
            [_modelArray setObject:self.expect atIndexedSubscript:0];
        }else{
        [_modelArray addObject:@""];
        }
        [numberArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_modelArray setObject:obj atIndexedSubscript:[obj integerValue]+1];
        }];
       
        if(self.opentimestamp){
        NSString * openTime = [NSString tranfromTimeyyyyMMddHHmm:[self.opentimestamp longLongValue] andType:@"HH:MM"];
            if(openTime){
            [_modelArray setObject:openTime atIndexedSubscript:_modelArray.count -1];
          
            }else{
            [_modelArray setObject:@"" atIndexedSubscript:_modelArray.count -1];
            }
        
        }
    
    
    }

    return  _modelArray;
}
@end
