//
//  ZhuanjiaTableViewCell.m
//  shensu
//
//  Created by shensu on 17/5/18.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "ZhuanjiaTableViewCell.h"

@implementation ZhuanjiaTableViewCell
-(void)setModel:(ZhuanjiaModel *)model
{
    [_ImageView sd_setImageWithURL:[NSURL URLWithString:model.poster[@"avatar"]]];
    _titleLable.text = model.poster[@"name"];
    _subLable.text = model.lastTenStatusText;
    _yueLable.text = model.dataInfo[0][@"dataText"];
    _yueget.text = model.dataInfo[1][@"dataText"];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}
-(void)layoutSubviews{
    [super layoutSubviews];
    _ImageView.layer.cornerRadius = _ImageView.width/2;
    _ImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
