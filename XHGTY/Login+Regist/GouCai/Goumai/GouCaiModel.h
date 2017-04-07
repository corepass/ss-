//
//  GouCaiModel.h
//  +
//
//  Created by shensu on 17/3/31.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GouCaiModel : NSObject
@property(copy,nonatomic) NSString * name;
@property(copy,nonatomic) NSString * qishu;
@property(copy,nonatomic) NSString * type;
@property(copy,nonatomic) NSString * peilv;
@property(assign,nonatomic) BOOL isSelected;
@end
