//
//  FDWeatherCollectionCell.m
//  FDCalendarDemo
//
//  Created by 杨健 on 2016/12/1.
//  Copyright © 2016年 fergusding. All rights reserved.
//

#import "FDWeatherCollectionCell.h"
#import "FXWeekWeather.h"

@interface FDWeatherCollectionCell()

@property (weak, nonatomic) IBOutlet UILabel *weekDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;

@property (weak, nonatomic) IBOutlet UILabel *fengLabel;
@end

@implementation FDWeatherCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setWeekWeather:(FXWeekWeather *)weekWeather{
    self.weekDayLabel.text = weekWeather.weekDay;
    self.dateLabel.text = weekWeather.date;
    self.tempLabel.text = weekWeather.temperature;
    self.weatherLabel.text = weekWeather.weather;
    if ([weekWeather.wind containsString:@"持续"]) {
        self.fengLabel.text = weekWeather.wind;
    }else{
        self.fengLabel.text = [NSString stringWithFormat:@"%@风",weekWeather.wind];
    }
    
    self.img.image = [UIImage imageNamed:weekWeather.code_day];
}

@end
