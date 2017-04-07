//
//  FXHomeMenuCycleCell.m
//  NewPuJing
//
//  Created by 杨健 on 2016/11/23.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "FXHomeMenuCycleCell.h"
#import "HttpTools.h"

@interface FXHomeMenuCycleCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;


@end

@implementation FXHomeMenuCycleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setImgName:(NSString *)imgName{
    
    [HttpTools downloadImageView:self.iconImageView withImageURL:imgName];
    
}

@end
