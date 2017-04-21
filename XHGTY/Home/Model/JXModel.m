//
//  JXModel.m
//  +
//
//  Created by shensu on 17/4/17.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "JXModel.h"

@implementation JXModel
-(NSArray *)getarc4randoArcount:(int)sumCount classCount:(int)count frome:(int)from tonumber:(int)tofrom{
   
    NSMutableArray * sumarray = [[NSMutableArray alloc] init];
    BOOL ishave = NO;
    for (int j =0 ; j<sumCount; j++) {
        NSMutableArray * array = [[NSMutableArray alloc] init];
        for (int i=0; i<count; i++) {
            int x ;
            NSString * y ;
            
            do {
                x = [self getRandomNumber:from to:tofrom];
                ishave = [array containsObject:@(x)];
        } while (ishave);
            y = [NSString stringWithFormat:@"%02d",x];
            [array addObject:y];
            NSLog(@"i=%d",i);
        }
        [sumarray addObject:array];
        NSLog(@"j=%d",j);
    }
    NSLog(@"%@",sumarray);
    return sumarray;
}
-(NSArray *)getarc4random{
   int count = self.cpCount?self.cpCount:6;
    NSMutableArray * array = [[NSMutableArray alloc] init];
    BOOL ishave = NO;
    for (int i=0; i<count; i++) {
        int x ;
        NSString * y ;
        do {
            x = [self getRandomNumber:01 to:32];
            ishave = [array containsObject:@(x)];
        } while (ishave);
        y = [NSString stringWithFormat:@"%02d",x];
        [array addObject:y];
        
    }
    
    NSArray *result = [array sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        return [obj1 compare:obj2]; //升序
        
    }];
    array = [NSMutableArray arrayWithArray:result];
    if (_isblue){
        int x ;
        NSString * y ;
        x =  [self getRandomNumber:01 to:17];
        
        y = [NSString stringWithFormat:@"%02d",x];
        
        [array addObject:y];
    }

    return array;
}
-(int)getRandomNumber:(int)from to:(int)to

{
    return (int)(from + (arc4random() % (to - from + 1)));
}
@end
