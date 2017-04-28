//
//  MNXHModel.m
//  +
//
//  Created by shensu on 17/4/20.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "MNXHModel.h"

@implementation MNXHModel
-(instancetype)copyWithZone:(NSZone *)zone{
    MNXHModel * model = [MNXHModel allocWithZone:zone];
    model.typeName = self.typeName;
    model.number = self.number;
    model.isSelected = self.isSelected;
    model.titleClor = self.titleClor;
    return model;
}
@end
