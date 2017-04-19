//
//  CalendarViewCell.m
//  FDCalendarDemo
//
//  Created by 杨健 on 2016/11/28.
//  Copyright © 2016年 fergusding. All rights reserved.
//

#import "CalendarViewCell.h"
#import "FDCalendar.h"

@interface CalendarViewCell()<FDCalendarDelegate>
@property (nonatomic,weak)FDCalendar *calendar;
@end

@implementation CalendarViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    FDCalendar *calendar = [[FDCalendar alloc] initWithCurrentDate:[NSDate date]];
    calendar.delegate = self;
   
    [self.contentView addSubview:calendar];
    self.calendar = calendar;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    NSLog(@"%@",NSStringFromCGRect(self.calendar.frame));
    
    self.calendar.frame = self.calendar.frame;
}

- (void)calendarSelectedDate:(NSDate *)selectedDate{
    if ([self.delegate respondsToSelector:@selector(selectedDate:)]) {
        [self.delegate selectedDate:selectedDate];
    }
}
@end
