//
//  ChossTableViewCell.m
//  APP
//
//  Created by 马罗罗 on 2017/4/21.
//  Copyright © 2017年 马罗罗. All rights reserved.
//

#import "ChossTableViewCell.h"

@implementation ChossTableViewCell


- (instancetype )initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
               [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.upLable];
        [self.contentView addSubview:self.downLable];
        [self.contentView addSubview:self.lineView];
        
        
    }
    return self;
}
- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]init];
//        _iconImageView.image = [UIImage imageNamed:@".png"];
//        _iconImageView.backgroundColor = [UIColor redColor];
    }
    return _iconImageView;
}
- (UILabel *)upLable
{
    if (!_upLable) {
        _upLable = [[UILabel alloc]init];
        _upLable.text = @"中商百货中商广场店";
        _upLable.textAlignment = NSTextAlignmentLeft;
        _upLable.textColor = [UIColor blackColor];
        _upLable.font = [UIFont systemFontOfSize:15];
    }
    return _upLable;
}
- (UILabel *)downLable
{
    if (!_downLable) {
        _downLable = [[UILabel alloc]init];
        _downLable.text = @"中商百货中商广场店";
           _downLable.textAlignment = NSTextAlignmentLeft;
        _downLable.textColor = [UIColor blackColor];
        _downLable.font = [UIFont systemFontOfSize:15];
    }
    return _downLable;
}
- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
        
    }
    return _lineView;
}
- (void)layoutSubviews{
    
    [super layoutSubviews];
    

    self.iconImageView.frame = CGRectMake(15, 0, 44, 44);
    self.iconImageView.centerY = self.contentView.centerY;
    
    self.upLable.frame = CGRectMake(CGRectGetMaxX(self.iconImageView.frame)+30, 20, 100, 20);
    self.downLable.frame = CGRectMake(self.upLable.x, CGRectGetMaxY(self.upLable.frame)+5, 100, 20);
    self.lineView.frame = CGRectMake(25, self.height - 1, self.width, 1);
    
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
