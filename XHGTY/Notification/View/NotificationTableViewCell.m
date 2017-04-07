//
//  NotificationTableViewCell.m
//  YunGou
//
//  Created by x on 16/6/2.
//  Copyright © 2016年 bangma. All rights reserved.
//

#import "NotificationTableViewCell.h"
#import "Masonry.h"
#import "NotificationViewController.h"
#define W_mainsize [UIScreen mainScreen].bounds.size.width
@implementation NotificationTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        if ([reuseIdentifier isEqualToString:@"isResdNotification"]) {
            [self setisReadNotificationUI];
        }else if([reuseIdentifier isEqualToString:@"unReadNotification"])
        {
             [self setunReadNotificationUI];
        }else if([reuseIdentifier isEqualToString:@"DetaNotifi"])
        {
            [self setDetaNotifiUI];
        }

    }
    return self;
}
-(void)setisReadNotificationUI
{
    _TitleLable = [[UILabel alloc]init];
    [_TitleLable setFont:[UIFont systemFontOfSize:16]];
    [self.contentView addSubview:_TitleLable];
    _SubclassLable = [[UILabel alloc]init];
    [_SubclassLable setFont:[UIFont systemFontOfSize:11]];
    [_SubclassLable setTextColor:[UIColor grayColor]];
    [self.contentView addSubview:_SubclassLable];
//    _RedView = [[UIView alloc]init];
//    [_RedView.layer setCornerRadius:3];
//    [_RedView setBackgroundColor:[UIColor redColor]];
//    [self.contentView addSubview:_RedView];
    
    [_TitleLable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(15);
        make.right.mas_equalTo(self.contentView).offset(-40);
        make.top.mas_equalTo(self.contentView).offset(15);
        make.height.mas_equalTo(16);
    }];
    [_SubclassLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(15);
        make.right.mas_equalTo(self.contentView).offset(-40);
        make.top.mas_equalTo(_TitleLable.mas_bottom).offset(10);
        make.height.mas_equalTo(11);
    }];
    
//    [_RedView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.contentView).offset(15);
//        make.centerY.mas_equalTo(_TitleLable.mas_centerY);
//        make.height.mas_equalTo(6);
//        make.width.mas_equalTo(0);
//    }];

}
-(void)setunReadNotificationUI
{
    _TitleLable = [[UILabel alloc]init];
    [_TitleLable setFont:[UIFont systemFontOfSize:16]];

    [self.contentView addSubview:_TitleLable];
    _SubclassLable = [[UILabel alloc]init];
    [_SubclassLable setFont:[UIFont systemFontOfSize:11]];
    [_SubclassLable setTextColor:[UIColor grayColor] ];
    [self.contentView addSubview:_SubclassLable];
    _RedView = [[UIView alloc]init];
    [_RedView.layer setCornerRadius:3];
    [_RedView setBackgroundColor:[UIColor redColor]];
    [self.contentView addSubview:_RedView];
    
    [_TitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_RedView.mas_right).offset(5);
        make.right.mas_equalTo(self.contentView).offset(-40);
        make.top.mas_equalTo(self.contentView).offset(15);
        make.height.mas_equalTo(16);
    }];
    [_SubclassLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(15);
        make.right.mas_equalTo(self.contentView).offset(-40);
        make.top.mas_equalTo(_TitleLable.mas_bottom).offset(10);
        make.height.mas_equalTo(11);
    }];
    
    [_RedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(15);
        make.centerY.mas_equalTo(_TitleLable.mas_centerY);
        make.height.mas_equalTo(6);
        make.width.mas_equalTo(6);
    }];
    
}
-(void)setDetaNotifiUI
{
    _TitleLable = [[UILabel alloc]init];
    [_TitleLable setFont:[UIFont systemFontOfSize:16]];
  
    [self.contentView addSubview:_TitleLable];
    _SubclassLable = [[UILabel alloc]init];
    [_SubclassLable setFont:[UIFont systemFontOfSize:11]];
    [_SubclassLable setTextColor:[UIColor grayColor] ];
    [self.contentView addSubview:_SubclassLable];
    _RedView = [[UIView alloc]init];
    [_RedView.layer setCornerRadius:3];
    [_RedView setBackgroundColor:[UIColor redColor]];
    [self.contentView addSubview:_RedView];
    
    _DetaLable = [[UILabel alloc]init];
    [_DetaLable setFont:[UIFont systemFontOfSize:11]];
    _DetaLable.numberOfLines = 0;
    [_DetaLable setLineBreakMode:NSLineBreakByWordWrapping];
    [_DetaLable setTextColor:[UIColor grayColor] ];
    [self.contentView addSubview:_DetaLable];
    [self drawlineview:self.contentView];
    [_TitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(15);
        make.right.mas_equalTo(self.contentView).offset(-40);
        make.top.mas_equalTo(self.contentView).offset(15);
        make.height.mas_equalTo(16);
    }];
    [_SubclassLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).offset(15);
        make.right.mas_equalTo(self.contentView).offset(-40);
        make.top.mas_equalTo(_TitleLable.mas_bottom).offset(10);
        make.height.mas_equalTo(11);
    }];
    
    [_DetaLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_SubclassLable.mas_bottom).offset(20);
        make.left.mas_equalTo(self.contentView.mas_left).offset(15);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-15);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-15);

    }];


}
-(void)setModel:(NotificationModel *)Model
{
    _Model = Model;
    _TitleLable.text = _Model.TitleLable;
    _SubclassLable.text = _Model.SubLable;
    _DetaLable.text = _Model.DetaLable;

}

-(void) prepareForReuse
{
    [super prepareForReuse];
}
-(void)drawlineview:(UIView *)view
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:view.bounds];
    [shapeLayer setPosition:view.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];

    // 设置虚线颜色为blackColor
  //  [shapeLayer setStrokeColor:[[UIColor blackColor] CGColor]];
//    [shapeLayer setStrokeColor:[[UIColor alloc] init:@"#eeeeee"].CGColor];

    // 3.0f设置虚线的宽度
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];

    // 3=线的宽度 1=每条线的间距
    [shapeLayer setLineDashPattern:
     [NSArray arrayWithObjects:[NSNumber numberWithInt:3],
      [NSNumber numberWithInt:1],nil]];

    // Setup the path
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 10, 60);
    CGPathAddLineToPoint(path, NULL,W_mainsize-20,60);

    // Setup the path
    //  CGMutablePathRef path = CGPathCreateMutable();
    // 0,10代表初始坐标的x，y
    // 320,10代表初始坐标的x，y
//    CGPathMoveToPoint(path, NULL, 0, 10);
//    CGPathAddLineToPoint(path, NULL, 320,10);
//
    [shapeLayer setPath:path];
    CGPathRelease(path);

    // 可以把self改成任何你想要的UIView, 下图演示就是放到UITableViewCell中的
    [view.layer addSublayer:shapeLayer];
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
