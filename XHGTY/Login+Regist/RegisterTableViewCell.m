//
//  RegisterTableViewCell.m
//  YunGou
//
//  Created by x on 16/5/24.
//  Copyright © 2016年 bangma. All rights reserved.
//

#import "RegisterTableViewCell.h"


#define  mainsize [UIScreen mainScreen].bounds.size.width-30
@implementation RegisterTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.TitleLable];
        [self.contentView addSubview:self.RegisterTextFiled];
    }
    return self;
}
-(UIImageView *)TitleLable
{
    if (!_TitleLable) {
        _TitleLable = [[UIImageView alloc]initWithFrame:CGRectMake(15,(self.contentView.frame.size.height- 17)/2,21, 17)];
        [_TitleLable setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _TitleLable;
}
-(UITextField *)RegisterTextFiled
{
    if (!_RegisterTextFiled) {
        _RegisterTextFiled = [[UITextField alloc]initWithFrame:CGRectMake(50,0,mainsize-65, self.contentView.frame.size.height)];
        [_RegisterTextFiled setFont:[UIFont systemFontOfSize:14]];
        [_RegisterTextFiled setTextColor:[UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1]];
    }
    return _RegisterTextFiled;


}
-(UIButton *)RegisterButton
{
    if (!_RegisterButton) {
        _RegisterButton = [[UIButton alloc]init];


    }
    return _RegisterButton;
    
    
}
-(void)setModel:(RegusterCellModel *)Model
{
    _Model = Model;
    if(_Model)
    {
        _TitleLable.image = [UIImage imageNamed:_Model.Title];
        _RegisterTextFiled.placeholder = _Model.placeholder;
        if ([_Model.Title isEqualToString:@"captcha"]) {
            _RegisterTextFiled.frame =CGRectMake(50,0,mainsize-155, self.contentView.frame.size.height);
            [self.contentView addSubview:self.RegisterButton];
        }
    }

}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
