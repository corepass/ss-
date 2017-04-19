//
//  FDNewWeatherCell.h
//  FDCalendarDemo
//
//  Created by 杨健 on 2016/12/1.
//  Copyright © 2016年 fergusding. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FXWeather;

@interface FDNewWeatherCell : UITableViewCell

@property (nonatomic,strong)FXWeather *weather;

@property (nonatomic,strong)NSArray *weathers;

@property (nonatomic,strong)NSArray *chuanyis;



@end
