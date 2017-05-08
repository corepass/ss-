//
//  FXModel.h
//  +
//
//  Created by shensu on 17/4/25.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXModel : NSObject
@property(copy,nonatomic) NSString * expect;
@property(copy,nonatomic) NSString * opencode;
@property(copy,nonatomic) NSString * opentime;
@property(copy,nonatomic) NSString * opentimestamp;
@property(copy,nonatomic) NSMutableArray * modelArray;

@end
/*{"expect":"614366","opencode":"06,04,09,02,10,03,05,08,07,01","opentime":"2017-04-25 15:02:30","opentimestamp":1493103750}*/
