//
//  FXHomeMenuCycleView.h
//  NewPuJing
//
//  Created by 杨健 on 2016/11/23.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FXAd;

@protocol FXHomeMenuSelectedDelegate <NSObject>

- (void)fxHomeMenuSelected:(NSString *)url;

@end

@interface FXHomeMenuCycleView : UIView

+(instancetype)homeMenuCycleView;

@property (nonatomic,strong)NSArray<FXAd*> *totalAds;

@property (nonatomic,assign)id<FXHomeMenuSelectedDelegate> delegate;

@end
