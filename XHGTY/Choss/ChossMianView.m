//
//  ChossMianView.m
//  APP
//
//  Created by 马罗罗 on 2017/4/21.
//  Copyright © 2017年 马罗罗. All rights reserved.
//

#import "ChossMianView.h"

@implementation ChossMianView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.footView];
        [self addSubview:self.chossTableView];
        [self.footView.chossleftView.addButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.footView.chossleftView.reduceButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.footView.chossrightView.addButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.footView.chossrightView.reduceButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.footView.determineButton addTarget:self action:@selector(deterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.chossTableView.views.determineButton addTarget:self action:@selector(deterClick:) forControlEvents:UIControlEventTouchUpInside];
        
        

        
    }
    return self;
}
- (void)deterClick:(UIButton*)sender{
    
    if (self.chossTableView.views.determineButton.selected) {
        self.footView.determineButton.userInteractionEnabled = NO;
        self.footView.determineButton.backgroundColor = [UIColor grayColor];
    }
    else{
        self.footView.determineButton.userInteractionEnabled = YES;
        self.footView.determineButton.backgroundColor = [UIColor redColor];
    }
    
}
- (void)deterButtonClick:(UIButton *)sender{
    int leftNumber = [self.footView.chossleftView.numberLable.text intValue];
    int rightNumber = [self.footView.chossrightView.numberLable.text intValue];
    int moneyNumber = leftNumber*2*rightNumber;
    NSLog(@"确认购买按钮");
    if (self.deterButtonClickBlock){
        self.deterButtonClickBlock(_chossTableView.cpNumber,[NSString stringWithFormat:@"%d",moneyNumber]);
    }
    
}
- (void)leftButtonClick:(UIButton *)sender{
    
    int leftNumber = [self.footView.chossleftView.numberLable.text intValue];
    int rightNumber = [self.footView.chossrightView.numberLable.text intValue];
    
    if (sender ==self.footView.chossleftView.reduceButton) {
        
        if (leftNumber ==1) {
            self.footView.chossleftView.numberLable.text = [NSString stringWithFormat:@"%d",1];
 
        }
        else{
            leftNumber--;
        self.footView.chossleftView.numberLable.text = [NSString stringWithFormat:@"%d",leftNumber];
          
        }
    }
    if (sender ==self.footView.chossrightView.reduceButton) {
        
        if (rightNumber ==1) {
            self.footView.chossrightView.numberLable.text = [NSString stringWithFormat:@"%d",1];
        }
        else{
            rightNumber--;
            self.footView.chossrightView.numberLable.text = [NSString stringWithFormat:@"%d",rightNumber];
        }
    }
    
    [self setUpMoney];
    
}
- (void)setUpMoney{
    
    int leftNumber = [self.footView.chossleftView.numberLable.text intValue];
    int rightNumber = [self.footView.chossrightView.numberLable.text intValue];
    
    int moneyNumber = leftNumber*2*rightNumber;
    
    
    
    self.footView.moneyLable.text = [NSString stringWithFormat:@"投注金额: %d 注",moneyNumber];
    
    NSString *str = self.footView.moneyLable.text;
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:str];
    NSRange range = NSMakeRange(5, self.footView.moneyLable.text.length - 6);
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:range];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor yellowColor] range:range];
     self.footView.moneyLable.attributedText = attributedStr;
    
  
}
- (void)rightButtonClick:(UIButton *)sender{
    
    int leftNumber = [self.footView.chossleftView.numberLable.text intValue];
    int rightNumber = [self.footView.chossrightView.numberLable.text intValue];
    
    if (sender ==self.footView.chossleftView.addButton) {
        
        leftNumber++;
        self.footView.chossleftView.numberLable.text = [NSString stringWithFormat:@"%d",leftNumber];

    }
    if (sender ==self.footView.chossrightView.addButton) {
        
        rightNumber++;
        self.footView.chossrightView.numberLable.text = [NSString stringWithFormat:@"%d",rightNumber];
        
    }
  [self setUpMoney];
}
- (FootView *)footView{
    
    if (!_footView) {
        
        _footView = [[FootView alloc]init];
        
    }
    return _footView;
}
- (ChossTableView *)chossTableView{
    
    if (!_chossTableView) {
        _chossTableView = [[ChossTableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _chossTableView;
}
- (void)layoutSubviews
{
    [super layoutSubviews];

    self.footView.frame = CGRectMake(0, self.height -80, self.width, 80);
    self.chossTableView.frame = CGRectMake(0, 64,self.width, self.height - 64 - self.footView.height);

}

@end
