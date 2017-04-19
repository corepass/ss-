//
//  FXHomeMenuCell.h
//  NewPuJing
//
//  Created by 杨健 on 2016/11/23.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  LotteryKind;

@interface FXHomeMenuCell : UICollectionViewCell
@property(nonatomic,strong) UIButton * buton ; 
@property (nonatomic,strong)LotteryKind *kind;
@property (nonatomic,copy)NSString *lotteryName;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@end
