//
//  RecordOneViewCell.m
//  NewPuJing
//
//  Created by 杨健 on 2016/12/7.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "RecordOneViewCell.h"
#import "FXBoard.h"

@interface RecordOneViewCell()
@property (weak, nonatomic) IBOutlet UIButton *boardBtn;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end

@implementation RecordOneViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setBoard:(FXBoard *)board{
    _board = board;
    
    [self.boardBtn setTitle:board.num forState:UIControlStateNormal];
    [self.boardBtn setBackgroundImage:[UIImage imageNamed:board.color] forState:UIControlStateNormal];
    self.name.text = [NSString stringWithFormat:@"%@/%@",board.shengxiao,board.wuxing];
}

@end
