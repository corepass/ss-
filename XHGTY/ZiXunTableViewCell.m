//
//  ZiXunTableViewCell.m
//  +
//
//  Created by 杨健 on 2017/1/3.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "ZiXunTableViewCell.h"
#import "FXZixun.h"
#import "UIImageView+WebCache.h"

@interface ZiXunTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftBottom;
@property (weak, nonatomic) IBOutlet UILabel *rightBottom;

@end

@implementation ZiXunTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setZixun:(FXZixun *)zixun{
    _zixun = zixun;
    
    self.titleNameLabel.text = zixun.title;
    self.leftBottom.text = zixun.source;
    self.rightBottom.text = [NSString stringWithFormat:@"%ld",(long)zixun.replyCount];
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:zixun.imgsrc]];
    
}

@end
