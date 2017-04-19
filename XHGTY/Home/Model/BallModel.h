//
//  BallModel.h
//  +
//
//  Created by shensu on 17/4/19.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BallModel : NSObject
@property(copy,nonatomic) NSString * Vid;
@property(copy,nonatomic) NSString * No;
@property(copy,nonatomic) NSString * Sclass;
@property(copy,nonatomic) NSString * Issue;
@property(copy,nonatomic) NSString * Day;
@property(copy,nonatomic) NSString * Date;
@property(copy,nonatomic) NSString * HTI;
@property(copy,nonatomic) NSString * GTI;
@property(copy,nonatomic) NSString * Xi;
@property(copy,nonatomic) NSString * HN;
@property(copy,nonatomic) NSString * GN;
@property(assign,nonatomic) BOOL Status;
@property(assign,nonatomic) BOOL  ScStatus;
@property(assign,nonatomic) BOOL Turn;
@property(assign,nonatomic) CGFloat SJ;
@property(assign,nonatomic) NSInteger HS;
@property(assign,nonatomic) NSInteger GS;
@end
