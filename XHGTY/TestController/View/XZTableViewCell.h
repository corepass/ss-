//
//  XZTableViewCell.h
//  FDCalendarDemo
//
//  Created by 杨健 on 2016/11/29.
//  Copyright © 2016年 fergusding. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FXStart;


typedef enum : NSUInteger {
    FXStartSelectedLuck,
    FXStartSelectedNews,
    FXStartSelectedTest,
    FXStartSelectedDiscover,
    FXStartSelectedZJ,
} FXStartSelected;


@protocol XZTableViewCellDelegate <NSObject>

-(void)XZcellSelected:(FXStartSelected)startSelected;
- (void)changeStart:(FXStart *)start;

@end

@interface XZTableViewCell : UITableViewCell

@property (nonatomic,strong)FXStart *start;

@property (nonatomic,assign)id<XZTableViewCellDelegate> delegate;
@end
