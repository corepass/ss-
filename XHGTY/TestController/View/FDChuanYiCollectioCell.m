//
//  FDChuanYiCollectioCell.m
//  FDCalendarDemo
//
//  Created by 杨健 on 2016/12/1.
//  Copyright © 2016年 fergusding. All rights reserved.
//

#import "FDChuanYiCollectioCell.h"

@interface FDChuanYiCollectioCell()
@property (weak, nonatomic) IBOutlet UILabel *chuanyiLabel;

@end

@implementation FDChuanYiCollectioCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setChuanyiName:(NSString *)chuanyiName{
   
    NSRange range = [chuanyiName rangeOfString:@"空调"];
    
    if (range.location != NSNotFound) {
        NSString * newstr = [chuanyiName substringToIndex:chuanyiName.length-2];
        self.chuanyiLabel.text = newstr;
    }else{
        self.chuanyiLabel.text = chuanyiName;
    }

    
    
}

@end
