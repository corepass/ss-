//
//  FXforumViewCell.m
//  NewPuJing
//
//  Created by 杨健 on 2016/12/7.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "FXforumViewCell.h"
#import "FXforum.h"
@interface FXforumViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *time;
@end

@implementation FXforumViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setForum:(FXforum *)forum{
    _forum = forum;
    
   [self.icon sd_setImageWithURL:[NSURL URLWithString:forum.avatar]];
    
    self.name.text = forum.user_nicename;
    self.title.text = forum.title;

    self.time.text = [forum.add_time substringToIndex:10];
}


@end
