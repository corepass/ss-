//
//  PeiLvTableViewCell.m
//  +
//
//  Created by 杨健 on 2017/1/3.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "PeiLvTableViewCell.h"
#import "NALLabelsMatrix.h"
#import "FXPeiLv.h"
#import "FXPeiLvDetail.h"

@interface PeiLvTableViewCell()


@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *hostNameBtnArr;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *firstHostBtnArr;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *nowHostBtnArr;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;



@end

@implementation PeiLvTableViewCell

//
//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
//   
//    for (UIView *view in self.contentView.subviews) {
//        if ([view isKindOfClass:[NALLabelsMatrix class]]) {
//            return;
//        }
//    }
//    
//    NALLabelsMatrix* matrix = [[NALLabelsMatrix alloc] initWithFrame:CGRectMake(0, 20, 320, 100) andColumnsWidths:[[NSArray alloc] initWithObjects:@70,@126,@126, nil]];
//    matrix.tag = 10086;
//    [self.contentView addSubview:matrix];
//    self.theMatrix = matrix;
//}


- (void)setPeiLv:(FXPeiLv *)peiLv{
    _peiLv = peiLv;
    
    NSString *lastTitle = [NSString stringWithFormat:@"%@%@%@-%@ vs %@",peiLv.leagueName,peiLv.matchCode,peiLv.matchTime,peiLv.hostName,peiLv.visitName];
    self.titleLabel.text = lastTitle;
  
   
    
    for (int index = 0; index < peiLv.ouOdds.count; index ++) {
        FXPeiLvDetail *detail = peiLv.ouOdds[index];
        
        UIButton *hostNameBtn = self.hostNameBtnArr[index];
        [hostNameBtn setTitle:detail.companyCnName forState:UIControlStateNormal];
        
        UIButton *middleBtn = self.firstHostBtnArr[index];
         NSString *middleStr = [NSString stringWithFormat:@"%@   %@   %@",detail.firstHostOdds,detail.firstDrawOdds,detail.firstVisitOdds];
        [middleBtn setTitle:middleStr forState:UIControlStateNormal];
        
        UIButton *lastBtn = self.nowHostBtnArr[index];
        NSString *lastStr = [NSString stringWithFormat:@"%@   %@   %@",detail.nowHostOdds,detail.nowDrawOdds,detail.nowVisitOdds];
        [lastBtn setTitle:lastStr forState:UIControlStateNormal];
    }
}

@end
