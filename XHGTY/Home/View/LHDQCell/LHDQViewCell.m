//
//  LHDQViewCell.m
//  NewPuJing
//
//  Created by 杨健 on 2016/12/8.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "LHDQViewCell.h"
#import "LHDQMenu.h"

@interface LHDQViewCell()

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation LHDQViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setMenu:(LHDQMenu *)menu{
    _menu = menu;
    
    self.name.text = menu.name;
    self.title.text = menu.content;
}

@end
