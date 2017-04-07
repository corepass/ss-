//
//  FXNewsViewCell.m
//  FDCalendarDemo
//
//  Created by 杨健 on 2017/1/6.
//  Copyright © 2017年 fergusding. All rights reserved.
//

#import "FXNewsViewCell.h"
#import "FXNews.h"
#import "UIImageView+WebCache.h"
@interface FXNewsViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end

@implementation FXNewsViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setNews:(FXNews *)news{
    _news = news;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:news.thumbnail_pic_s]];
    self.titleLabel.text = news.title;
    self.nameLabel.text = news.author_name;
}

@end
