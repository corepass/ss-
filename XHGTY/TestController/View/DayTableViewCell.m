//
//  DayTableViewCell.m
//  FDCalendarDemo
//
//  Created by 杨健 on 2016/11/28.
//  Copyright © 2016年 fergusding. All rights reserved.
//

#import "DayTableViewCell.h"
#import "NSString+Extension.h"
#import "AdModel.h"
#import "FXNavigationController.h"
#import "FXWebViewController.h"

@interface DayTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *dayNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *chineseLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *festivalLabel;
@property (weak, nonatomic) IBOutlet UILabel *yiLabel;
@property (weak, nonatomic) IBOutlet UILabel *jiLabel;
@property (nonatomic,strong)NSTimer *timer;

@end


@implementation DayTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
 
}


- (void)setDetailDict:(NSDictionary *)detailDict{
    _detailDict = detailDict;
    
    
    NSString *yearAndMonAndDay = [NSString stringWithFormat:@"%@[%@]年 %@月 %@日",detailDict[@"TianGanDiZhiYear"],detailDict[@"LYear"],detailDict[@"TianGanDiZhiMonth"],detailDict[@"TianGanDiZhiDay"]];
    //NSLog(@"self.detailDict = %@",self.detailDict);
    
    self.dayNumLabel.text = detailDict[@"dayNum"];
 
    
    self.jiLabel.text = [NSString stringWithFormat:@"忌  %@",detailDict[@"Ji"]];
    self.yiLabel.text = [NSString stringWithFormat:@"宜  %@",detailDict[@"Yi"]];
    
    self.jiLabel.attributedText = [NSString renderText:self.jiLabel.text targetStr:@"忌 " font:[UIFont systemFontOfSize:14] andColor:[UIColor colorWithRed:60/255.0 green:150/255.0 blue:206/255.0 alpha:1]];
    self.yiLabel.attributedText = [NSString renderText:self.yiLabel.text targetStr:@"宜 " font:[UIFont systemFontOfSize:14] andColor:[UIColor colorWithRed:218/255.0 green:76/255.0 blue:92/255.0 alpha:1]];
    
    NSString *str = [NSString stringWithFormat:@"%@ %@",detailDict[@"LJie"],detailDict[@"GJie"]];
    
    //NSLog(@"str = %@",str);
    if ([str isEqualToString:@" "]) {
       self.festivalLabel.text = @"";
    }else{
         self.festivalLabel.text = str;
    }
    
    self.weekDayLabel.text = yearAndMonAndDay;
    self.chineseLabel.text = [NSString stringWithFormat:@"%@%@    %@",detailDict[@"chineseDay"],detailDict[@"Weekday"],detailDict[@"weekDay"]];
    
}







@end
