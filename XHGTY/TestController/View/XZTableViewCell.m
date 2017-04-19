//
//  XZTableViewCell.m
//  FDCalendarDemo
//
//  Created by 杨健 on 2016/11/29.
//  Copyright © 2016年 fergusding. All rights reserved.
//

#import "XZTableViewCell.h"
#import "LPLevelView.h"
#import "FXStart.h"


@interface XZTableViewCell()
@property (weak, nonatomic) IBOutlet LPLevelView *startView;
@property (weak, nonatomic) IBOutlet UILabel *clolorLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *supeiLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *xzname;

@end

@implementation XZTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.startView.iconColor = [UIColor orangeColor];
    self.startView.iconSize = CGSizeMake(10, 10);
    self.startView.canScore = NO;
    self.startView.animated = NO;
    
}

//改变星座
- (IBAction)switchAction:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(changeStart:)]) {
        [self.delegate changeStart:nil];
    }
    
}



- (IBAction)bottomClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(XZcellSelected:)]) {
        [self.delegate XZcellSelected:sender.tag];
    }
}


- (void)setStart:(FXStart *)start{
    NSString *tempStr = start.all;
    NSRange range = [tempStr rangeOfString:@"%"];
    NSString *newStr = [tempStr substringToIndex:range.location];
    
    float floatValue = [newStr intValue] / 100.0;
    
    self.startView.level = floatValue;
    self.clolorLabel.text = start.color;
    self.numLabel.text = [NSString stringWithFormat:@"%d",start.number];
    self.supeiLabel.text = start.QFriend;
    self.detailLabel.text = start.summary;
    self.img.image = [UIImage imageNamed:start.name];
    self.xzname.text = start.name;
}

@end
