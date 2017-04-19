//
//  FXShiChenViewCell.m
//  FDCalendarDemo
//
//  Created by 杨健 on 2016/12/5.
//  Copyright © 2016年 fergusding. All rights reserved.
//

#import "FXShiChenViewCell.h"

@interface FXShiChenViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation FXShiChenViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setTitleName:(NSString *)titleName{
    self.titleLabel.text = titleName;
}

@end
