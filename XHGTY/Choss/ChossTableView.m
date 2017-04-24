//
//  ChossTableView.m
//  APP
//
//  Created by 马罗罗 on 2017/4/21.
//  Copyright © 2017年 马罗罗. All rights reserved.
//

#import "ChossTableView.h"
#import "ChossTableViewCell.h"
#import "MNXHModel.h"
@implementation ChossTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
  
        
        self.backgroundColor = [UIColor whiteColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.dataSource = self;
        self.delegate = self;
        
        self.views = [[TableViewFootView alloc]initWithFrame:CGRectMake(0, 0, self.width, 60)];
        self.tableFooterView = self.views;
        

    }
    return self;
}
-(void)setDataArray:(NSArray<MNXHModel *> *)dataArray
{
    _dataArray = dataArray;
    for (NSArray * array  in _dataArray) {
        MNXHModel * model =   array[0];
        self.titleImage = model.typeName;
        break;
    }

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *identifier = @"indetife";
    
    ChossTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[ChossTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    if (indexPath.row == self.dataArray.count - 1) {
        cell.lineView.hidden = YES;
    }
    else{
        cell.lineView.hidden = NO;
    }
    
    NSString * cpNumber = @"";
    for (NSArray * class in self.dataArray) {
        for (MNXHModel * model in class) {
            NSString * appedStr = [NSString stringWithFormat:@"%@|",model.number];
            cpNumber = [cpNumber stringByAppendingString: appedStr];
        }
    
    }
    self.cpNumber = cpNumber;
    cell.iconImageView.image = [UIImage imageNamed:self.titleImage];
    cell.upLable.text = [cpNumber substringWithRange:NSMakeRange(0, cpNumber.length -1)];
    cell.downLable.text = @"一注 2 元";
    return cell;
    
    
}


@end
