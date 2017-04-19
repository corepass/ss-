//
//  FXZSTViewController.m
//  +
//
//  Created by shensu on 17/4/18.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "FXZSTViewController.h"

#import "FXTableViewCell.h"

@interface FXZSTViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *titleTableView;//标题TableView
@property (nonatomic, strong) UITableView *infoTableView;//内容TableView
@property (nonatomic, strong) UIScrollView *contentView;//内容容器
@property (nonatomic, strong) NSArray *infoArr;//数组

@end

@implementation FXZSTViewController {
    CGFloat _kOriginX;
    CGFloat _kScreenWidth;
    CGFloat _kScreenHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    
    [self configData];
    [self configTableHeader];
    [self configInfoView];
    
}
-(void)getData{
    [HttpTools getCustonWithPath:@"http://api.dabai28.com/api28.php?name=pc28&type=json" parms:nil success:^(id JSON) {
        if ([JSON isKindOfClass:[NSArray class]]){
            _infoArr = JSON;
        }
    } :^(NSError *error) {
        
    }];
    
}
- (void)configData {
    
    _kOriginX = 120;
    _kScreenWidth = self.view.frame.size.width;
    _kScreenHeight = self.view.frame.size.height;
//    _infoArr = @[@{@"title":@"出团日期", @"routeName":@"线路名称一", @"time":@"2015/11/21", @"num":@"20", @"price":@"124.0", @"code":@"DAGSDSASA"},
//                 @{@"title":@"余位", @"routeName":@"线路名称二", @"time":@"2015/11/21", @"num":@"34", @"price":@"234", @"code":@"TAGDFASFAF"},
//                 @{@"title":@"价格", @"routeName":@"线路名称三", @"time":@"2015/11/21", @"num":@"12", @"price":@"634", @"code":@"GHGASDAS"},
//                 @{@"title":@"团代号", @"routeName":@"线路名称四", @"time":@"2015/11/56", @"num":@"54", @"price":@"632", @"code":@"DAADSFAD"}];
}

//MARK:- 头部视图
- (void)configTableHeader {
    
    _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(_kOriginX, 0, _kScreenWidth - _kOriginX, _kScreenHeight)];
    _contentView.delegate = self;
    _contentView.showsVerticalScrollIndicator = NO;
    _contentView.showsHorizontalScrollIndicator = NO;
    _contentView.contentSize = CGSizeMake(400, _kScreenHeight);
    _contentView.bounces = NO;
    [self.view addSubview:_contentView];
    
    UILabel *titleLabel = [self quickCreateLabelWithLeft:0 width:_kOriginX title:@"开奖期数"];
    [self.view addSubview:titleLabel];
    
    for (int i = 0; i < _infoArr.count; i++) {
        CGFloat x = i * 100;
        UILabel *label = [self quickCreateLabelWithLeft:x width:100 title:[[_infoArr objectAtIndex: i] objectForKey:@"title"]];
        label.textAlignment = NSTextAlignmentCenter;
        [_contentView addSubview:label];
    }
}
//MARK:- 详细内容
- (void)configInfoView {
    _titleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, _kOriginX, _kScreenHeight) style:UITableViewStylePlain];
    _titleTableView.dataSource = self;
    _titleTableView.delegate = self;
    _titleTableView.showsVerticalScrollIndicator = NO;
    _titleTableView.showsHorizontalScrollIndicator = NO;
    _titleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_titleTableView];
    
    _infoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 400, _kScreenHeight) style:UITableViewStylePlain];
    _infoTableView.delegate = self;
    _infoTableView.dataSource = self;
    _infoTableView.showsVerticalScrollIndicator = NO;
    _infoTableView.showsHorizontalScrollIndicator = NO;
    _infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_contentView addSubview:_infoTableView];
}

//MARK:- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _infoArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _titleTableView) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"titleTable"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"titleTable"];
        }
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = [[_infoArr objectAtIndex:indexPath.row] objectForKey:@"routeName"];
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        if (indexPath.row%2 == 1) {
            cell.backgroundColor = [UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1];
        } else {
            cell.backgroundColor = [UIColor whiteColor];
        }
        return cell;
    } else {
        
        NSString *ident = @"InfoCell";
        FXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"InfoCell" owner:nil options:nil] lastObject];
        }
        if (indexPath.row%2 == 1) {
            cell.backgroundColor = [UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1];
        } else {
            cell.backgroundColor = [UIColor whiteColor];
        }
        //    [cell setDataWithStr:[_infoArr objectAtIndex:indexPath.row]];
        return cell;
    }
}

//MARK:- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"选中了%@", [_infoArr[indexPath.row] objectForKey:@"routeName"]);
}

//MARK:- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _titleTableView) {
        [_infoTableView setContentOffset:CGPointMake(_infoTableView.contentOffset.x, _titleTableView.contentOffset.y)];
    }
    if (scrollView == _infoTableView) {
        [_titleTableView setContentOffset:CGPointMake(0, _infoTableView.contentOffset.y)];
    }
}

//MARK:- 快速创建label
- (UILabel *)quickCreateLabelWithLeft:(CGFloat)left width:(CGFloat)width title:(NSString *)title {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(left, 10, width, 40)];
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
