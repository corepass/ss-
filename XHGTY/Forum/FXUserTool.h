//
//  FXUserTool.h
//  CityCook
//
//  Created by yang on 16/3/1.
//  Copyright © 2016年 Sichuan City Cooking Brother. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "FXAccount.h"

@interface FXUserTool : NSObject

single_interface(FXUserTool)

- (void)saveAccount:(FXAccount*)account;

@property (nonatomic,strong)FXAccount *account;

@end
