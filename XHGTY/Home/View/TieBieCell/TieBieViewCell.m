//
//  TieBieViewCell.m
//  NewPuJing
//
//  Created by 杨健 on 2016/12/9.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "TieBieViewCell.h"

@interface TieBieViewCell()
@property (weak, nonatomic) IBOutlet UIButton *boardBtn;

@end

@implementation TieBieViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.boardBtn.layer.cornerRadius = self.boardBtn.width/2;
    // Initialization code
}

- (void)setNumber:(NSString *)number{
    [self.boardBtn setTitle:number forState:UIControlStateNormal];
}


@end
