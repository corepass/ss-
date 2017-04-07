//
//  RecordViewController.m
//  NewPuJing
//
//  Created by 杨健 on 2016/12/7.
//  Copyright © 2016年 杨健. All rights reserved.
//

#import "RecordViewController.h"
#import "RecordViewCell.h"
#import "FXRecord.h"
#import "FXBoard.h"
#import "TitleButton.h"
#import "RecordInfoViewController.h"
#import "HttpTools.h"
#import "AppURLdefine.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "AppDefine.h"
@interface RecordViewController ()<UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSMutableArray *totalRecords;
@property (nonatomic,strong)UIPickerView *pickView;
@property (nonatomic,strong)NSMutableArray *totalYears;
@property (nonatomic,strong)TitleButton *titleBtn;

@end

@implementation RecordViewController{
    int _pageNum;
    UIToolbar *_toolBar;
    UIPickerView *_pickView;
    UIView *_coverView;
    NSString *_selectStr;
    NSInteger _selectedIndex;
    NSString *_selectyear;
}

static NSString *const RecordViewCellID = @"RecordViewCell";

-(NSMutableArray *)totalRecords{
    if (_totalRecords == nil) {
        _totalRecords = [NSMutableArray array];
    }
    return _totalRecords;
}

- (NSMutableArray *)totalYears{
    if (_totalYears == nil) {
        _totalYears = [NSMutableArray array];
    }
    return _totalYears;
}

- (TitleButton *)titleBtn{
    if (_titleBtn == nil) {
        _titleBtn = [TitleButton buttonWithType:UIButtonTypeCustom];
        
        [_titleBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleBtn;
}

-(UIPickerView *)pickView{
    if (_pickView == nil) {
        _pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 64, kScreenW, 140)];
        _pickView.backgroundColor = [UIColor whiteColor];
        _pickView.dataSource = self;
        _pickView.delegate = self;
    }
    return _pickView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _pageNum = 1;
  
    [self.tableView registerNib:[UINib nibWithNibName:@"RecordViewCell" bundle:nil] forCellReuseIdentifier:RecordViewCellID];
    self.tableView.rowHeight = 105;
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreItems)];
    self.tableView.mj_footer.hidden = YES;
    
    [self loadNewItems];
}


-(void)btnClick:(TitleButton *)btn{
    btn.selected = !btn.selected;
    btn.enabled = !btn.enabled;
    [self addPickView];
    
}

- (void)addPickView{
    _coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 140+64, kScreenW, kScreenH - 64 - 140)];
    _coverView.backgroundColor = [UIColor lightGrayColor];
    _coverView.alpha = 0.5;
    [self.view addSubview:_coverView];
    
    [self.view addSubview:self.pickView];
    [self createToolBar];
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.totalYears.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *str = self.totalYears[row];
    NSString *lastStr = [NSString stringWithFormat:@"六合彩%@年历史开奖数据",str];
    return lastStr;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    _selectStr = self.totalYears[row];
    _selectedIndex = row;
}


#pragma mark - 添加ToolBar
-(void)createToolBar{
    UIToolbar *toolbar=[[UIToolbar alloc] initWithFrame:CGRectMake(0,140+64, kScreenW, 40)];
    [toolbar setBarTintColor:[UIColor whiteColor]];
    UIBarButtonItem *lefttem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    lefttem.tintColor = [UIColor blackColor];
    
    UIBarButtonItem *centerSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
    right.tintColor = [UIColor blackColor];
    
    toolbar.items=@[lefttem,centerSpace,right];
    [self.view addSubview:toolbar];
    _toolBar = toolbar;
}


- (void)doneClick{
    [self cancel];
    _pageNum = 1;
    
    NSString *year = self.totalYears[_selectedIndex];
    NSString *yearStr = [NSString stringWithFormat:@"六合彩%@年开奖记录",year];
    [self.titleBtn setTitle:yearStr forState:UIControlStateNormal];
    
    self.tableView.mj_footer.hidden = YES;
    [self.totalRecords removeAllObjects];
    [self.tableView reloadData];
    
    
    [self loadDateWithYear:year];
    _selectyear = year;
}

- (void)loadDateWithYear:(NSString *)yearStr{
    
 
    [HttpTools getWithPath:kHistory parms:@{@"year" : yearStr} success:^(id JSON) {
        //
        
        NSArray *arr = JSON[@"content"];
        
        self.tableView.mj_footer.hidden = (arr.count <10);
        
        for (NSDictionary *dict in arr) {
            FXRecord *record = [[FXRecord alloc]init];
            record.longdate = dict[@"longdate"];
            record.shortperiod = dict[@"shortperiod"];
            
            for (int i = 1; i<8; i++) {
                FXBoard *board = [self createBoard:dict andIndex:i];
                [record.totalBords addObject:board];
            }
            
            FXBoard *addBoard = [[FXBoard alloc]init];
            [record.totalBords insertObject:addBoard atIndex:6];
            
            [self.totalRecords addObject:record];
        }
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
      
        
    } :^(NSError *error) {
        //
    }];
}


- (void)cancel{
    [_pickView removeFromSuperview];
    [_toolBar removeFromSuperview];
    [_coverView removeFromSuperview];
    self.titleBtn.selected = NO;
    self.titleBtn.enabled = YES;
}


- (void)loadNewItems{
    
    
    [HttpTools getWithPath:kHistory parms:nil success:^(id JSON) {
        //
        NSArray *arr0 = JSON[@"history_year"];
        for (NSDictionary *dict in arr0) {
            [self.totalYears addObject:dict[@"year"]];
        }
        
        
        NSArray *arr = JSON[@"content"];
        
        self.tableView.mj_footer.hidden = (arr.count <10);
        
        
        for (NSDictionary *dict in arr) {
            FXRecord *record = [[FXRecord alloc]init];
            record.longdate = dict[@"longdate"];
            record.shortperiod = dict[@"shortperiod"];
            
            for (int i = 1; i<8; i++) {
                FXBoard *board = [self createBoard:dict andIndex:i];
                [record.totalBords addObject:board];
            }
            
            FXBoard *addBoard = [[FXBoard alloc]init];
            [record.totalBords insertObject:addBoard atIndex:6];
            
            [self.totalRecords addObject:record];
        }
        
        [self.tableView reloadData];
        
        NSString *lastStr = nil;
        if (_selectyear) {
            lastStr = [NSString stringWithFormat:@"六合彩%@年开奖记录",_selectyear];
        }else{
            lastStr = [NSString stringWithFormat:@"六合彩%@年开奖记录",self.totalYears.firstObject];
        }
        
        [self.titleBtn setTitle:lastStr forState:UIControlStateNormal];
        self.navigationItem.titleView = self.titleBtn;
        
        
    } :^(NSError *error) {
        //
    }];
}


-(void)loadMoreItems{
    _pageNum ++;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    dict[@"year"] = _selectyear ? _selectyear : self.totalYears.firstObject;
    
    dict[@"p"] = [NSString stringWithFormat:@"%d",_pageNum];
    
    [HttpTools getWithPath:kHistory parms:dict success:^(id JSON) {
        //
        
        if ([JSON[@"status"]intValue] == 2) {
            self.tableView.mj_footer.hidden = YES;
            return ;
        }else{
            self.tableView.mj_footer.hidden = NO;
        }
       
        
        NSArray *arr = JSON[@"content"];
        if ([JSON[@"status"]intValue] == 2) {
            //[MBProgressHUD showError:JSON[@"info"]];
            return;
        }
        
        self.tableView.mj_footer.hidden = (arr.count <10);
        
        for (NSDictionary *dict in arr) {
            FXRecord *record = [[FXRecord alloc]init];
            record.longdate = dict[@"longdate"];
            record.shortperiod = dict[@"shortperiod"];
            
            for (int i = 1; i<8; i++) {
                FXBoard *board = [self createBoard:dict andIndex:i];
                [record.totalBords addObject:board];
            }
            
            FXBoard *addBoard = [[FXBoard alloc]init];
            [record.totalBords insertObject:addBoard atIndex:6];
            
            [self.totalRecords addObject:record];
        }
        
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } :^(NSError *error) {
        //
    }];
}


- (FXBoard *)createBoard:(NSDictionary *)dict andIndex:(int)index{
    
    FXBoard *board = [[FXBoard alloc]init];
    
    NSString *numStr = [NSString stringWithFormat:@"num%d",index];
    board.num = dict[numStr];
    
    NSString *colorStr = [numStr stringByAppendingString:@"bose"];
    board.color = dict[colorStr];
    
    NSString *shengxiaoStr = [numStr stringByAppendingString:@"shengxiao"];
    board.shengxiao = dict[shengxiaoStr];
    
    NSString *wuxingStr = [numStr stringByAppendingString:@"wuxing"];
    board.wuxing= dict[wuxingStr];
    
    return board;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.totalRecords.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecordViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RecordViewCellID];
    cell.record = self.totalRecords[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RecordInfoViewController *recordVC = [[RecordInfoViewController alloc]init];

    recordVC.oneRecord = self.totalRecords[indexPath.row];
    
    [self.navigationController pushViewController:recordVC animated:YES];
}

@end
