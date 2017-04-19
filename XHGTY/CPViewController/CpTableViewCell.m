//
//  CpTableViewCell.m
//  +
//
//  Created by shensu on 17/4/18.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "CpTableViewCell.h"

@implementation CpTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.distance.textColor = [[UIColor alloc] initWithRed:237/255.0 green:31/255.0 blue:65/255.0 alpha:1];
    self.cpImage.layer.cornerRadius = 4;
    self.cpImage.layer.masksToBounds = YES;
}
-(void)setPoi:(AMapPOI *)poi{
    _poi = poi;
    CGFloat distance = _poi.distance;
    self.distance.text = [NSString stringWithFormat:@"距离：%.2fkm",distance/1000];
    if(!_poi.images.firstObject.url){
    [self.cpImage sd_setImageWithURL:[NSURL URLWithString:@"http://store.is.autonavi.com/showpic/57e00e51f243476dd5caf720139009aa"]];
    
    }else{
      [self.cpImage sd_setImageWithURL:[NSURL URLWithString:_poi.images.firstObject.url]];
    }
    
  //  [self.cpImage sd_setImageWithURL:[NSURL URLWithString:_poi.images.firstObject.url]];
    [self.titleLable setText:_poi.name];
    _subTitle.numberOfLines = 2;
    _subTitle.lineBreakMode = NSLineBreakByWordWrapping;
    [self.subTitle setText:[NSString stringWithFormat:@"%@-%@",_poi.address,_poi.type]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
