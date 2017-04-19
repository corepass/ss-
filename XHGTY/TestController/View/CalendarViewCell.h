//
//  CalendarViewCell.h
//  FDCalendarDemo
//
//  Created by 杨健 on 2016/11/28.
//  Copyright © 2016年 fergusding. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CalendarDelegate <NSObject>

- (void)selectedDate:(NSDate *)selectedDate;

@end

@interface CalendarViewCell : UITableViewCell

@property(nonatomic,assign)id<CalendarDelegate> delegate;


@end
