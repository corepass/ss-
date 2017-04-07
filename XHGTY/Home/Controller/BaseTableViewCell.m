//
//  BaseTableViewCell.m
//  NewPuJing
//
//  Created by 杨健 on 2016/11/17.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "BaseTableViewCell.h"


@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
