//
//  UIBarButtonItem+Exstion.h
//  BaiSiBuDeJie
//
//  Created by yang on 16/2/16.
//  Copyright © 2016年 Sichuan City Cooking Brother. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Exstion)

/** 返回一个带背景图片的barbuttonitem*/
+(UIBarButtonItem *)itemWithImge:(NSString *)image selectedIcon:(NSString *)selectedImage target:(id)target andSEL:(SEL)sel;
/** 只返回一个名称的barbuttonitem*/
+(UIBarButtonItem *)itemWithName:(NSString *)name target:(id)target andSEL:(SEL)sel;
@end
