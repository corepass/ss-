//
//  MNXHModel.h
//  +
//
//  Created by shensu on 17/4/20.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNXHModel : NSObject
@property(copy,nonatomic) NSString * typeName;
@property(copy,nonatomic) NSString * number;
@property(assign,nonatomic) BOOL isSelected ;
@property(copy,nonatomic) UIColor * titleClor;
@end
