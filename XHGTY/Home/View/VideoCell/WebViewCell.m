//
//  WebViewCell.m
//  NewPuJing
//
//  Created by 杨健 on 2016/12/9.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "WebViewCell.h"

@interface WebViewCell()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end


@implementation WebViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    self.webView.scrollView.bounces=NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}



- (void)setHtmlStr:(NSString *)htmlStr{
    [self.webView loadHTMLString:htmlStr baseURL:[NSURL fileURLWithPath: [[NSBundle mainBundle]  bundlePath]]];
}

@end
