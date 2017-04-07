//
//  FXVerticalBtn.m
//  BaiSiBuDeJie
//
//  Created by yangjian on 16/2/23.
//  Copyright © 2016年 Sichuan City Cooking Brother. All rights reserved.
//

#import "FXVerticalBtn.h"

// 文字的高度比例
#define kTitleRatio 0.3

@implementation FXVerticalBtn

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (void)awakeFromNib{
   [super awakeFromNib];
    self.imageView.contentMode = UIViewContentModeCenter;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

//- (void)layoutSubviews{
//    [super layoutSubviews];
//    
//    //调整图片
//    self.imageView.x = 0;
//    self.imageView.y = 0;
//    self.imageView.width = self.width;
//    self.imageView.height = self.imageView.width;
//    
//    //调整文字
//    self.titleLabel.x = 0;
//    self.titleLabel.y = self.imageView.height;
//    self.titleLabel.width = self.width;
//    self.titleLabel.height = self.height - self.titleLabel.y;
//    self.titleLabel.textAlignment = NSTextAlignmentCenter;
//    self.titleLabel.font = kFont(14);
//    self.titleLabel.textColor = [UIColor blackColor];
//}

#pragma mark 调整内部ImageView的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = 0;
    CGFloat imageY = 5;
    CGFloat imageWidth = contentRect.size.width;
    CGFloat imageHeight = contentRect.size.height * ( 1- kTitleRatio );
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}

#pragma mark 调整内部UILabel的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleHeight = contentRect.size.height * kTitleRatio;
    CGFloat titleY = contentRect.size.height - titleHeight+4;
    CGFloat titleWidth = contentRect.size.width;
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
}

@end
