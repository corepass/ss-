//
//  FXNoNetWorkView.h
//  CityCook
//
//  Created by 杨健 on 16/5/30.
//  Copyright © 2016年 Sichuan City Cooking Brother. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol requestNetWorDelegate <NSObject>

-(void)requestNetWorkAgain;

@end

typedef void(^requestNewWorkBlock)();

@interface FXNoNetWorkView : UIView


+(instancetype)noNetWorkView;

/** daili */
@property (nonatomic,assign)id<requestNetWorDelegate> delegate;

@end
