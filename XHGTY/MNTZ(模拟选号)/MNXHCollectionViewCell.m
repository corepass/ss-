//
//  MNXHCollectionViewCell.m
//  +
//
//  Created by shensu on 17/4/20.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "MNXHCollectionViewCell.h"

@implementation MNXHCollectionViewCell
-(void)setModel:(MNXHModel *)model{
    _model = model;
    if (_model.isSelected){
        self.numberLable.backgroundColor = model.titleClor;
        self.numberLable.textColor = [UIColor whiteColor];
        self.numberLable.layer.borderWidth = 0;
       
     }else{
        self.numberLable.textColor = model.titleClor;
    }

}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.numberLable.layer.cornerRadius = 17.5;
    self.numberLable.layer.masksToBounds = YES;
    self.numberLable.backgroundColor = [UIColor whiteColor];
    self.numberLable.layer.borderWidth = 1.0;
    self.numberLable.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    // Initialization code
}
-(void)prepareForReuse{
    [super prepareForReuse];
    self.numberLable.layer.cornerRadius = 17.5;
    self.numberLable.backgroundColor = [UIColor whiteColor];
    self.numberLable.textColor = [[UIColor alloc] initWithRed:237/255.0 green:31/255.0 blue:65/255.0 alpha:1];
    self.numberLable.layer.cornerRadius = 17.5;
    self.numberLable.layer.borderWidth = 1.0;
    self.numberLable.layer.borderColor = [[UIColor lightGrayColor] CGColor];

}
@end
