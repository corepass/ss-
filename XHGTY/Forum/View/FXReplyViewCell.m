//
//  FXReplyViewCell.m
//  NewPuJing
//
//  Created by 杨健 on 2016/12/10.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "FXReplyViewCell.h"
#import "FXReply.h"

@interface FXReplyViewCell()

@property (weak, nonatomic) IBOutlet UILabel *replyContentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation FXReplyViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setReply:(FXReply *)reply{
    _reply = reply;
    
    [self.headIcon sd_setImageWithURL:[NSURL URLWithString:reply.avatar]];
    self.nameLabel.text = reply.user_nicename;
    self.timeLabel.text = reply.add_time;
    self.replyContentLabel.text = reply.content;
}

@end
