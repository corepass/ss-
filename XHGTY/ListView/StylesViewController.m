//
//  StylesViewController.m
//  LMReportDemo
//
//  Created by Chenly on 16/4/18.
//  Copyright © 2016年 Little Meaning. All rights reserved.
//

#import "StylesViewController.h"
#import "LMReport.h"
#import "LMRStyle+Demo.h"
#import "FXModel.h"

typedef NS_ENUM (NSUInteger , Colortype){
    ColortypeDf,
    ColortypeDs,
    ColortypeZdy,
    
};
@interface StylesViewController () <LMReportViewDatasource>

@property (nonatomic, strong) LMReportView *reportView;
@property (nonatomic, assign) LMRStyleType currentStyle;
@property (nonatomic, strong) NSMutableArray<FXModel *> * dataArray;
@property (nonatomic,strong) NSArray * heardArray;
@property (nonatomic,assign) Colortype  colorType;
@property (nonatomic,assign) Colortype  currentType;
@property(strong,nonatomic) UIButton *  button ;
@end

@implementation StylesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getdata];
    self.title = @"走势图";
    _dataArray = [[NSMutableArray alloc] init];
    LMRStyle *style = [LMRStyle blueStyle];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.reportView = [[LMReportView alloc] init];
    self.reportView.datasource = self;
    self.reportView.style = style;
    [self.view addSubview:self.reportView];
    UIBarButtonItem * right = [[UIBarButtonItem alloc] initWithTitle:@"主题" style:UIBarButtonItemStyleDone target:self action:@selector(changeStyle:)];
    right.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = right;
    [self.reportView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    self.currentStyle = LMRStyleTypeBlue;
    self.currentStyle = ColortypeZdy;
}

-(void)getdata{

 [HttpTools getCustonCAIPIAOWithPath:@"http://f.apiplus.cn/cqssc-20.json" parms:nil success:^(id JSON) {
     if([JSON isKindOfClass:[NSArray class]]){
             [_dataArray removeAllObjects];
           _dataArray = [FXModel mj_objectArrayWithKeyValuesArray:JSON];
     }
     dispatch_async(dispatch_get_main_queue(), ^{
              [self.reportView reloadData];
     });

 } :^(NSError *error) {
     [SVProgressHUD showErrorWithStatus:@"数据请求失败"];
     dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [SVProgressHUD dismiss];
     });
 }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

}

- (void)changeStyle:(id)sender {
    UIAlertAction *actionBlue = [UIAlertAction actionWithTitle:@"蓝色" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self setStyle:LMRStyleTypeBlue];
    }];
    UIAlertAction *actionGreen = [UIAlertAction actionWithTitle:@"绿色" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self setStyle:LMRStyleTypeGreen];
    }];
    
    UIAlertAction *actionDS = [UIAlertAction actionWithTitle:@"单双" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _colorType = ColortypeDs;
      [self setTextColorType:_colorType];
    }];
    UIAlertAction *actionZdy = [UIAlertAction actionWithTitle:@"随机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _colorType = ColortypeZdy;
         [self setTextColorType:ColortypeZdy];
    }];
    
    UIAlertAction * actionDf = [UIAlertAction actionWithTitle:@"默认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _colorType = ColortypeDf;
         [self setTextColorType:ColortypeDf];
    }];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"切换样式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:actionBlue];
    [alert addAction:actionGreen];
    [alert addAction:actionDS];
    [alert addAction:actionZdy];
    [alert addAction:actionDf];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

- (void)setStyle:(LMRStyleType)style {
    
    if (self.currentStyle == style ) {
        return;
    }
    self.reportView.style = style == LMRStyleTypeBlue ? [LMRStyle blueStyle] : [LMRStyle greenStyle];
    self.currentStyle = style;
    [UIView animateWithDuration:0.5 animations:^{
        [self.reportView reloadData];
    }];
}
- (void)setTextColorType:(Colortype)style {
    
    if (self.currentType == style ) {
        return;
    }
    self.currentType  = style;
    [UIView animateWithDuration:0.5 animations:^{
        [self.reportView reloadData];
    }];
}

#pragma mark - <LMReportViewDatasource>

- (NSInteger)numberOfRowsInReportView:(LMReportView *)reportView {
    NSLog(@"row------%lu------",(unsigned long)_dataArray.count);
    
    
    return _dataArray.count == 0 ? 20 : _dataArray.count + 1;
}
-(void)addBtn{
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    [_button setTitle:@"刷新" forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _button.titleLabel.font = [UIFont systemFontOfSize:14];
    _button.adjustsImageWhenDisabled = NO;
    _button.backgroundColor = [[UIColor alloc] initWithRed:237/255.0 green:31/255.0 blue:65/255.0 alpha:1];
    [_button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
    UIWindow * windows = [UIApplication sharedApplication].keyWindow;
    windows.frame = [UIScreen mainScreen].bounds;
    [windows addSubview:_button];
    CGRect rect = [UIScreen mainScreen].bounds;
    if (rect.size.width > 320){
        _button.frame = CGRectMake(self.view.width - 65, self.view.height - 79 , 60, 60);
        _button.layer.cornerRadius = 30;
    }else{
        _button.frame = CGRectMake(self.view.width - 55, self.view.height - 79 , 50, 50);
        _button.layer.cornerRadius = 25;
    }

    
    
 
}
-(void)btnClick:(UIButton *)btn{
    btn.userInteractionEnabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        btn.userInteractionEnabled = YES;
    });
    [self getdata];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addBtn];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_button removeFromSuperview];

}
- (NSInteger)numberOfColsInReportView:(LMReportView *)reportView {
      NSLog(@"col*****%lu",(unsigned long)self.heardArray.count);
    return self.heardArray.count ;
}
-(NSArray *)heardArray{
    if(!_heardArray){
        _heardArray =@[@"期号",@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"时间"];
    }

    return _heardArray;
}
- (LMRGrid *)reportView:(LMReportView *)reportView gridAtIndexPath:(NSIndexPath *)indexPath {
    LMRGrid *grid = [[LMRGrid alloc] init];
    grid.font = [UIFont systemFontOfSize:10];
    if (indexPath.row == 0){
        grid.text = _heardArray[indexPath.col];
    }else if (indexPath.row < _dataArray.count + 1){
        FXModel * model = _dataArray[indexPath.row -1];
        grid.text = model.modelArray[indexPath.col];
        NSInteger col = indexPath.col;
        if (0 < col && col < 11){
            switch (_colorType) {
                case ColortypeDs:
                    if ([grid.text intValue] % 2 == 0){
                        grid.backgroundColor = [[UIColor alloc] initWithRed:237/255.0 green:31/255.0 blue:65/255.0 alpha:1];
                        grid.textColor = [UIColor whiteColor];
                    }
                    break;
                case ColortypeZdy:
                    if ([grid.text intValue] % 2 == 0){
                        grid.backgroundColor = [[UIColor alloc] initWithRed:[self getRandomNumber:150 to:255]/255.0 green:[self getRandomNumber:150 to:255]/255.0 blue:[self getRandomNumber:150 to:255]/255.0 alpha:1];
                        grid.textColor = [UIColor whiteColor];
                    }
                default:
                    
                    break;
            }
        }
       
        
    }

    
//    grid.text = [NSString stringWithFormat:@"%ld-%ld", indexPath.row, indexPath.col];
    return grid;
}
-(int)getRandomNumber:(int)from to:(int)to

{
    return (int)(from + (arc4random() % (to - from + 1)));
}
@end
