//
//  BallTableViewCell.m
//  +
//
//  Created by shensu on 17/4/19.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "BallTableViewCell.h"

@implementation BallTableViewCell
-(void)setModel:(BallModel *)model{
    _model = model;
    _opentime.text =  _model.No;
    _type.text = _model.Sclass;
    _state.text = _model.Status ? @"已开赛" :@"未开赛";
    [_oneteam sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cdn2.woying.com/img/zq/team/%@",_model.HTI]]];
    _onename.text = _model.HN;
    [_twoteam sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://cdn2.woying.com/img/zq/team/%@",_model.GTI]]];
    _bstime.text = [_model.Date substringWithRange:NSMakeRange(11, 5)];
    _twoname.text = _model.GN;
    if (_model.Status){
        _bfLable.text = [NSString stringWithFormat:@"%ld:%ld",(long)_model.HS,(long)_model.GS];
        _bfLable.textColor = [[UIColor alloc] initWithRed:237/255.0 green:31/255.0 blue:65/255.0 alpha:1];
    }else{
    _bfLable.text = @"-----";
    }



}
-(NSString *)data:(NSString *)str{
    NSString* timeStr = str;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSDate * date = [formatter dateFromString:timeStr];
    return [formatter stringFromDate:date];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
