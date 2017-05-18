//
//  ZhuanjiaModel.h
//  shensu
//
//  Created by shensu on 17/5/18.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZhuanjiaModel : NSObject
@property(strong,nonatomic) NSString * rowindex;
@property(strong,nonatomic) NSDictionary * poster;
@property(strong,nonatomic) NSString * lastTenStatusText;
@property(strong,nonatomic) NSString * recommendCounts;
@property(strong,nonatomic) NSArray * dataInfo;

@end
