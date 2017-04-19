//
//  FXWeather.h
//  FDCalendarDemo
//
//  Created by 杨健 on 2016/12/1.
//  Copyright © 2016年 fergusding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXWeather : NSObject

@property (nonatomic,copy)NSString *cityName;

/**
 温度
 */
@property (nonatomic,copy)NSString *temperature;

/**
 湿度
 */
@property (nonatomic,copy)NSString *humidity;

/**
 天气
 */
@property (nonatomic,copy)NSString *info;

/**
 风
 */
@property (nonatomic,copy)NSString *wind;
/**
 级
 */
@property (nonatomic,copy)NSString *ji;
/**
 代码
 */
@property (nonatomic,copy)NSString *code;

/**
 空气指数
 */

@property (nonatomic,copy)NSString *kongqi;
@end
