//
//  HomegpcCollectionViewCell.m
//  +
//
//  Created by shensu on 17/4/20.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "HomegpcCollectionViewCell.h"

@implementation HomegpcCollectionViewCell
-(void)setModel:(gpcModel *)model{
    _model = model;
    [_gpcImage sd_setImageWithURL:[NSURL URLWithString:_model.photo]];
    _gpcTitle.text = _model.title;
    _gpcSubTitle.text = _model.summary;
    if([_model.photo isEqualToString:@""]){
     [_gpcTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(self.contentView).offset(8);
         make.right.mas_equalTo(self.contentView).offset(-8);
         make.top.mas_equalTo(self.contentView).offset(8);
         make.height.mas_offset(21);
     }];
        [_gpcSubTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(8);
            make.right.mas_equalTo(self.contentView).offset(-8);
            make.top.mas_equalTo(_gpcTitle.mas_bottom).offset(11);
            make.height.mas_offset(52);
            make.bottom.mas_equalTo(self.contentView).offset(-8);
        }];

    }else{
        [_gpcTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_gpcImage.mas_right).offset(16);
            make.right.mas_equalTo(self.contentView).offset(-8);
            make.top.mas_equalTo(self.contentView).offset(8);
            make.height.mas_offset(21);
        }];
        [_gpcSubTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_gpcImage.mas_right).offset(16);
            make.right.mas_equalTo(self.contentView).offset(-8);
            make.top.mas_equalTo(_gpcTitle.mas_bottom).offset(11);
            make.height.mas_offset(52);
            make.bottom.mas_equalTo(self.contentView).offset(-8);
        }];
        [_gpcImage mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView).offset(8);

            make.top.mas_equalTo(self.contentView).offset(8);
            make.height.mas_offset(115);
            make.width.mas_equalTo(84);
            make.bottom.mas_equalTo(self.contentView).offset(-8);
        }];
    
    }
    
}
-(void)layoutIfNeeded{
    [super layoutIfNeeded];

}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor whiteColor];
    // Initialization code
}

@end
