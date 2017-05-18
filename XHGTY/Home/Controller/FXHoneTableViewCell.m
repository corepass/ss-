//
//  FXHoneTableViewCell.m
//  shensu
//
//  Created by shensu on 17/5/18.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "FXHoneTableViewCell.h"

@implementation FXHoneTableViewCell
-(void)setModel:(FXHomeModel *)model
{
    [_typeImage sd_setImageWithURL:[NSURL URLWithString:model.articlepic]];
    _titleLable.text = model.title;
    _typeLable.text = model.lotteryname;
    _timeLable.text = model.addTime;

}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
