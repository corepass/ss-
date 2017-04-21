//
//  GouMaiView.m
//  +
//
//  Created by shensu on 17/3/31.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "GouMaiView.h"
#import "Masonry.h"
@implementation GouMaiView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 40, self.frame.size.height)];
        label.textColor = [UIColor grayColor];
        label.text = @"单注";
        [label setTextAlignment:NSTextAlignmentRight];
        [self addSubview:label];
        
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(60, 5, 80, self.frame.size.height - 10)];
        _textField.layer.cornerRadius = 4;
        _textField.layer.borderWidth = 1;
        [_textField setTextAlignment:NSTextAlignmentCenter];
        _textField.layer.borderColor = [[UIColor alloc]initWithRed:255/255.0 green:42.0/255.0 blue:26.0/255 alpha:1].CGColor;
        _textField.text = @"2";
        _textField.textColor = [UIColor grayColor];
        [self addSubview:_textField];
        
        UILabel * yunalabel = [[UILabel alloc] initWithFrame:CGRectMake(145, 0, 20, self.frame.size.height)];
        yunalabel.textColor = [UIColor grayColor];
        yunalabel.text = @"注";
        [yunalabel setTextAlignment:NSTextAlignmentRight];
        [self addSubview:yunalabel];
        
        _buyBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [_buyBtn setTitle:@"确实" forState:UIControlStateNormal];
        _buyBtn.frame = CGRectMake(self.frame.size.width - 95, 5, 90, 40);
        _buyBtn.layer.cornerRadius = 4;
        [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_buyBtn setBackgroundColor:[UIColor lightGrayColor]];

        [_buyBtn addTarget:self action:@selector(buyBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_buyBtn];

    
    }

    return  self;
}
-(void)buyBtnClick{
    if (_buyBtnClickBlcok){
        self.buyBtnClickBlcok();
    }

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
