//
//  MyProfileTableViewCell.m
//  YunGou
//
//  Created by x on 16/5/26.
//  Copyright © 2016年 bangma. All rights reserved.
//

#import "MyProfileTableViewCell.h"
#import "Masonry.h"
#import "XHGTY-swift.h"
#define  mainsize [UIScreen mainScreen].bounds.size.width
@implementation MyProfileTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.TitleLable];
        [self.TitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(15);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-15);
            make.height.mas_equalTo(14);
            make.width.mas_equalTo(170);
        }];
        [self.contentView addSubview:self.SubtitleLable];
        
        [self.contentView addSubview:self.UserImage];
        
        [self.contentView addSubview:self.RightImage];
        [self.RightImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-15);
            make.height.mas_equalTo(14);
            make.width.mas_equalTo(5);
        }];
    }

    return self;
}
-(UILabel *)TitleLable
{   if(!_TitleLable){
    _TitleLable = [[UILabel alloc]init];

    [_TitleLable setFont:[UIFont systemFontOfSize:14]];
    
   }
    return _TitleLable;
}
-(UILabel *)SubtitleLable
{   if(!_SubtitleLable){
    _SubtitleLable = [[UILabel alloc]initWithFrame:CGRectMake(mainsize-135, 15, 100, 14)];
    [_SubtitleLable setTextColor:[UIColor grayColor]];
    [_SubtitleLable setTextAlignment:NSTextAlignmentRight];
    [_SubtitleLable setFont:[UIFont systemFontOfSize:14]];
    
}
    return _SubtitleLable;
}
-(UIImageView *)UserImage
{   if(!_UserImage){
    _UserImage = [[UIImageView alloc]initWithFrame:CGRectMake(mainsize-64, 7.5, 29, 29)];
    _UserImage.layer.masksToBounds=YES;
    _UserImage.layer.cornerRadius =_UserImage.frame.size.width/2;    
}
    return _UserImage;
}
-(UIImageView *)RightImage
{   if(!_RightImage){
    _RightImage = [[UIImageView alloc]initWithFrame:CGRectMake(mainsize-20, 15, 5, 14)];
    [_RightImage setImage:[UIImage imageNamed:@"Right_Arrow"]];
}
    return _RightImage;
}

-(void)indexcell:(NSIndexPath *)idex andmodel:(MyProfileModel *)Model
{
    if ((idex.section== 0 &&idex.row == 0)||(idex.section== 2 &&idex.row == 1)) {
        [self.UserImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_RightImage.mas_left).offset(-15);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-7.5);
            make.height.mas_equalTo(29);
            make.width.mas_equalTo(29);
        }];
        if ((idex.section== 0 &&idex.row == 0)) {
            if ([[Apploction default] userImage]){
              [_UserImage setImage:[[Apploction default] userImage]];
            }else{
              [_UserImage setImage:[UIImage imageNamed:@"b94d5e6bf8da0c8f03d93d660d27d59b"]];
            }
           
     
        }else
        {
//          _UserImage.image = [UIImageView makeQRCodeImage:Model.imageName size:CGSizeMake(self.width, self.contentView.frame.size.width)];
        }
    }else
    {
        [self.SubtitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_RightImage.mas_left).offset(-15);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-15);
            make.height.mas_equalTo(14);
            make.width.mas_equalTo(100);
        }];
        _SubtitleLable.text = Model.subtitle;
    }
    
 

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
