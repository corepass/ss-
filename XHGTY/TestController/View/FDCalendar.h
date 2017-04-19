//
//  FDCalendar.h
//  FDCalendarDemo
//
//  Created by fergusding on 15/8/20.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import <UIKit/UIKit.h>

/*
 http://h5.jp.51wnl.com/wnl/xz/view?astro=taurus&versioncode=4.5.0  金牛
 
 http://h5.jp.51wnl.com/wnl/xz/view?astro=aries&versioncode=4.5.0 白羊
 */

@protocol FDCalendarDelegate <NSObject>

- (void)calendarSelectedDate:(NSDate *)selectedDate;


@end

@interface FDCalendar : UIView

@property (nonatomic,assign)id<FDCalendarDelegate> delegate;

- (instancetype)initWithCurrentDate:(NSDate *)date;


@end
