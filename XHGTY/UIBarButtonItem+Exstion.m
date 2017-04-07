//
//  UIBarButtonItem+Exstion.m
//  BaiSiBuDeJie
//
//  Created by yang on 16/2/16.
//  Copyright © 2016年 Sichuan City Cooking Brother. All rights reserved.
//

#import "UIBarButtonItem+Exstion.h"

@implementation UIBarButtonItem (Exstion)

+(UIBarButtonItem *)itemWithImge:(NSString *)image selectedIcon:(NSString *)selectedImage target:(id)target andSEL:(SEL)sel{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectedImage] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}
+(UIBarButtonItem *)itemWithName:(NSString *)name target:(id)target andSEL:(SEL)sel{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:name forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn sizeToFit];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

@end
