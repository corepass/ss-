//
//  FXViewController.m
//  NewHuangguan
//
//  Created by 杨健 on 2017/4/4.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "FXViewController.h"
#import "FDCalendar.h"
#import "FMDB.h"
#import "CalendarViewCell.h"
#import "DayTableViewCell.h"
#import "XZViewController.h"
#import "XZTableViewCell.h"
#import "NetWorkTools.h"
#import "MJExtension.h"
#import "FXStart.h"
#import "FDNewWeatherCell.h"
#import "FXWeekWeather.h"
#import "FXWeather.h"
#import "FXNLViewController.h"
#import "TitleButton.h"
#import "UIBarButtonItem+Exstion.h"
#import "FXWebViewController.h"
#import "AdModel.h"
#import "AppDelegate.h"

#import "TYBFViewController.h"
#import "WebViewController.h"
#import "LHDQViewController.h"

#define kRegisterNotify(_name, _selector) [[NSNotificationCenter defaultCenter] addObserver:self selector:_selector name:_name object:nil];
#define kRremoveNofify [[NSNotificationCenter defaultCenter] removeObserver:self];
#define kSendNotify(_name, _object) [[NSNotificationCenter defaultCenter] postNotificationName:_name object:_object];
#define ChineseMonths @[@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",@"九月", @"十月", @"冬月", @"腊月"]
#define ChineseDays @[@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",@"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十", @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十"]
#define xingzuos @[@"白羊座", @"金牛座", @"双子座", @"巨蟹座", @"狮子座", @"处女座", @"天秤座", @"天蝎座",@"射手座", @"魔蝎座", @"水瓶座", @"双鱼座"]
#define chinesexingzuos @[@"aries", @"taurus", @"gemini", @"cancer", @"leo", @"virgo", @"libra", @"scorpio",@"sagittarius", @"capricorn", @"aquarius", @"pisces"]


#define xingzhuos @[@"http://h5.jp.51wnl.com/wnl/xz/view?astro=aries", @"http://h5.jp.51wnl.com/wnl/xz/news?id=56&s=tag", @"http://h5.jp.51wnl.com/wnl/xz/test?id=66&s=tag", @"http://h5.jp.51wnl.com/wnl/xz/discover", @"http://h5.jp.51wnl.com/wnl/zj"]



@interface FXViewController ()<UITableViewDataSource,CalendarDelegate,XZTableViewCellDelegate,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong)NSMutableDictionary *detailDict;
@property (weak, nonatomic) TitleButton *titleButton;
@property (nonatomic,strong)UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)UIView *coverView;
@property (nonatomic,strong)UIToolbar *toolBar;
@property (nonatomic,strong)FXStart *start;

@property (nonatomic,strong)NSArray *chuanyis;

@property (nonatomic,strong)NSMutableArray *totallWeathers;

@property (nonatomic,strong)FXWeather *weather;

@property (nonatomic,strong)NSMutableArray *ads;
@end

@implementation FXViewController{
    UIToolbar *_xztoolBar;
    UIPickerView *_pickView;
    UIView *_xzcoverView;
    NSString *_selectedStr;
}

static NSString *CalendarViewCellID = @"CalendarViewCell";
static NSString *DayTableViewCellID = @"DayTableViewCell";
static NSString *FDNewWeatherCellID = @"FDNewWeatherCell";


static NSString *XZTableViewCellID = @"XZTableViewCell";

- (NSArray *)chuanyis{
    if (_chuanyis == nil) {
        _chuanyis = [NSArray array];
    }
    return _chuanyis;
}


-(NSMutableArray *)ads{
    if (_ads == nil) {
        _ads = [NSMutableArray array];
    }
    return _ads;
}

- (NSMutableArray *)totallWeathers{
    if (_totallWeathers == nil) {
        _totallWeathers = [NSMutableArray array];
    }
    return _totallWeathers;
}

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        
        _datePicker.datePickerMode = UIDatePickerModeDate;
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"Chinese"];
        _datePicker.backgroundColor = [UIColor whiteColor];
        CGRect frame = _datePicker.frame;
        
        _datePicker.minimumDate = [self getFormatDateWithDateString:@"1970-01-01" withFormatStyle:@"yyyy-MM-dd"];;
        _datePicker.maximumDate = [self getFormatDateWithDateString:@"2099-12-31" withFormatStyle:@"yyyy-MM-dd"];;
        
        frame.origin = CGPointMake(0, 44);
        _datePicker.frame = frame;
    }
    return _datePicker;
}




- (UIToolbar *)toolBar{
    if (_toolBar == nil) {
        _toolBar =[[UIToolbar alloc] initWithFrame:CGRectMake(0,44+216 , kScreenW, 40)];
        UIBarButtonItem *lefttem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
        lefttem.tintColor = [UIColor blackColor];
        
        UIBarButtonItem *centerSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
        right.tintColor = [UIColor blackColor];
        
        _toolBar.items=@[lefttem,centerSpace,right];
    }
    return _toolBar;
}


- (UIView *)coverView{
    if (_coverView == nil) {
        _coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 64 - 49)];
        
        _coverView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
    }
    return _coverView;
}

-(void)cancel{
    self.titleButton.selected = NO;
    [self.datePicker removeFromSuperview];
    [self.toolBar removeFromSuperview];
    [self.coverView removeFromSuperview];
}



- (void)doneClick{
    [self cancel];
    
    self.titleButton.selected = NO;
    
    [self selectedDate:self.datePicker.date];
    
    kSendNotify(@"pickView点击", self.datePicker.date);
}



- (NSMutableDictionary *)detailDict{
    if(_detailDict == nil){
        _detailDict = [NSMutableDictionary dictionary];
    }
    return _detailDict;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        if (kScreenW == 320) {
            return 305;
        }else if (kScreenW == 375){
            return 353;
        }
        return 386;
    }else if (indexPath.row == 1){
        NSString *str = [NSString stringWithFormat:@"%@ %@",self.detailDict[@"LJie"],self.detailDict[@"GJie"]];
        
        //NSLog(@"str = %@",str);
        if ([str isEqualToString:@" "]) {
            return 105;
        }else{
            return 120;
        }
    }else if (indexPath .row == 2){
        return 210;
    }
    
    return 220;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        CalendarViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CalendarViewCellID];
        cell.delegate = self;
        return cell;
    }else if(indexPath.row == 1){
        DayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DayTableViewCellID];
        //NSLog(@"self.detailDict = %@",self.detailDict);
        
        cell.detailDict = self.detailDict;
        return cell;
    }else if (indexPath.row == 2){
        FDNewWeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:FDNewWeatherCellID];
        if (self.weather) {
            cell.weather = self.weather;
        }
        
        if (self.totallWeathers.count) {
            cell.weathers = self.totallWeathers;
        }
        
        if (self.chuanyis.count) {
            cell.chuanyis = self.chuanyis;
        }
        return  cell;
    }
    
    XZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:XZTableViewCellID];
    cell.start = self.start;
    cell.delegate = self;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 2) {
        LHDQViewController *lhVC = [[LHDQViewController alloc]init];
        [self.navigationController pushViewController:lhVC animated:YES];
    }else if (indexPath.row == 3) {
        
//        NSInteger row = 0;
//        if (_selectedStr) {
//            row = [xingzuos indexOfObject:_selectedStr];
//        }
//        
//        NSString *strURL  = [NSString stringWithFormat:@"http://h5.jp.51wnl.com/wnl/xz/view?astro=%@",chinesexingzuos[row]];
//        RxWebViewController *webVC = [[RxWebViewController alloc]initWithUrl:[NSURL URLWithString:strURL]];
//        
//        [self.navigationController pushViewController:webVC animated:YES];
        TYBFViewController *gaopingVC = [[TYBFViewController alloc]init];
        gaopingVC.navigationItem.title =@"所有彩票";
        [self.navigationController pushViewController:gaopingVC animated:YES];
  
    }else if (indexPath.row == 1){
        FXNLViewController *nlVC = [[FXNLViewController alloc]init];
        
        
        nlVC.nlDict = [NSMutableDictionary dictionaryWithDictionary:self.detailDict];
        
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:nlVC];
        [self presentViewController:nav animated:YES completion:nil];
    }
}


//改变星座
- (void)changeStart:(FXStart *)start{
    [self addPickView];
}

- (void)XZcellSelected:(FXStartSelected)startSelected{
    
    NSString *urlStr = xingzhuos[startSelected];
    
    WebViewController *xzVC = [[WebViewController alloc]init];
    xzVC.url = [NSURL URLWithString:urlStr];
    [self.navigationController pushViewController:xzVC animated:YES];
    
}

- (NSString *)stringFromDate:(NSDate *)date {
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy年MM月dd日"];
    NSString *str = [formater stringFromDate:date];
    return str;
}



//添加pickViewer
- (void)addPickView{
    
    _xzcoverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - 140)];
    _xzcoverView.backgroundColor = [UIColor lightGrayColor];
    _xzcoverView.alpha = 0.5;
    [self.view addSubview:_xzcoverView];
    
    UIPickerView *pickView = [[UIPickerView alloc]initWithFrame:CGRectMake(0, kScreenH - 140 - 49 - 64, kScreenW, 140)];
    pickView.backgroundColor = [UIColor whiteColor];
    pickView.dataSource = self;
    pickView.delegate = self;
    
    [self.view addSubview:pickView];
    _pickView = pickView;
    
    [self createToolBar];
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 12;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return xingzuos[row];;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    _selectedStr = xingzuos[row];
    
}


#pragma mark - 添加ToolBar
-(void)createToolBar{
    UIToolbar *toolbar=[[UIToolbar alloc] initWithFrame:CGRectMake(0,kScreenH - 49 - 140 -40 - 64 , kScreenW, 40)];
    [toolbar setBarTintColor:[UIColor whiteColor]];
    UIBarButtonItem *lefttem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(xzcancel)];
    lefttem.tintColor = [UIColor blackColor];
    
    UIBarButtonItem *centerSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(xzdoneClick)];
    right.tintColor = [UIColor blackColor];
    
    toolbar.items=@[lefttem,centerSpace,right];
    [self.view addSubview:toolbar];
    _xztoolBar = toolbar;
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)xzdoneClick{
    [_pickView removeFromSuperview];
    [_xztoolBar removeFromSuperview];
    [_xzcoverView removeFromSuperview];
    if (_selectedStr) {
        [self loadData:_selectedStr];
    }
    
    
}

- (void)xzcancel{
    [_pickView removeFromSuperview];
    [_xztoolBar removeFromSuperview];
    [_xzcoverView removeFromSuperview];
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    TitleButton *btn = [TitleButton buttonWithType:UIButtonTypeCustom];
    //btn.backgroundColor = [UIColor redColor];
    [btn setFrame:CGRectMake(0, 0, 150, 20)];
    [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = btn;
    self.titleButton = btn;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CalendarViewCell" bundle:nil] forCellReuseIdentifier:CalendarViewCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"DayTableViewCell" bundle:nil] forCellReuseIdentifier:DayTableViewCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"XZTableViewCell" bundle:nil] forCellReuseIdentifier:XZTableViewCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"FDNewWeatherCell" bundle:nil] forCellReuseIdentifier:FDNewWeatherCellID];
    
    [self selectedDate:[NSDate date]];
    
    [self loadData: xingzuos[0]];
    
}


- (void)loadData:(NSString *)startName{
    
    [[NetWorkTools  sharedNetWorkTools]requestWithType:RequesTypeGET urlString:@"http://web.juhe.cn:8080/constellation/getAll" parms:@{@"consName": startName,@"type":@"today",@"key":@"4c30e2e769c1b92d3670cacb2aa97029"} success:^(id JSON) {
        self.start = [FXStart mj_objectWithKeyValues:JSON];
        
        [self.tableView reloadData];
    } :^(NSError *error) {
        //
    }];
   
}




- (void)btnclick:(TitleButton*)sender {
    
    sender.selected = !sender.selected;
    [self.view addSubview:self.coverView];
    [self.view addSubview:self.datePicker];
    [self.view addSubview:self.toolBar];
    
}

- (void)selectedDate:(NSDate *)selectedDate{
    
    [self GetChineseCalendarOfDate:selectedDate];
    
    [self weekStringFromDate:selectedDate];
    
    NSString *titleStr = [self stringFromDate:selectedDate];
    
    self.detailDict[@"selectedDate"] = titleStr;
    
    NSMutableString *lastString = [NSMutableString stringWithString:titleStr];
    
    
    NSString *monthString = [lastString substringWithRange:NSMakeRange(5, 2)];
    
    NSString *dayString = [lastString substringWithRange:NSMakeRange(8, 2)];
    
    BOOL monthFirst = NO;
    if ([monthString hasPrefix:@"0"]) {
        [lastString replaceCharactersInRange:NSMakeRange(5, 1) withString:@""];
        monthFirst = YES;
    }
    
    if ([dayString hasPrefix:@"0"]) {
        [lastString replaceCharactersInRange:NSMakeRange(monthFirst?7:8, 1) withString:@""];
    }
    
    [self.titleButton setTitle:lastString forState:UIControlStateNormal];
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //每周的第一天从星期一开始
    [calendar setFirstWeekday:1];
    NSDateComponents *comps2 = [calendar components:NSCalendarUnitWeekOfYear fromDate:selectedDate];
    
    [self.detailDict setObject:[NSString stringWithFormat:@"第%ld周",comps2.weekOfYear] forKey:@"Weekday"];
    
    
    NSDateFormatter *formater = [[NSDateFormatter alloc]init];
    [formater setDateFormat:@"yyyy/MM/dd"];
    NSString * selectedDay = [formater stringFromDate:selectedDate];
    NSLog(@"selectedDay = %@",selectedDay);
    NSArray *arr = [selectedDay componentsSeparatedByString:@"/"];
    
    NSString *yearStr = arr[0];
    NSString *monthStr = arr[1];
    NSString *dayStr = arr[2];
    
    NSString *newMonthStr = nil;
    NSString *newDayStr = nil;
    if ([monthStr hasPrefix:@"0"]) {
        newMonthStr = [monthStr substringFromIndex:1];
    }
    
    
    if ([dayStr hasPrefix:@"0"]) {
        newDayStr = [dayStr substringFromIndex:1];
    }
    
    NSString *lastStr = nil;
    if (newMonthStr && newDayStr) {
        lastStr = [NSString stringWithFormat:@"%@/%@/%@",yearStr,newMonthStr,newDayStr];
    }
    
    if (!newMonthStr && newDayStr) {
        lastStr = [NSString stringWithFormat:@"%@/%@/%@",yearStr,monthStr,newDayStr];
    }
    
    
    if (newMonthStr && !newDayStr) {
        lastStr = [NSString stringWithFormat:@"%@/%@/%@",yearStr,newMonthStr,dayStr];
    }
    
    
    if (!newMonthStr && !newDayStr) {
        lastStr = selectedDay;
    }
    
    NSString *dayNum = newDayStr ? newDayStr : dayStr;
    [self.detailDict setObject:dayNum forKey:@"dayNum"];
    
    
    NSString *dbPath =[self readyDatabase:@"main.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    [db open];
    
    FMResultSet *rs = [db executeQuery:@"select * from lunar where GregorianDateTime = ?", lastStr];
    
    while ([rs next]) {
        [self.detailDict setObject:[rs stringForColumn:@"Yi"] forKey:@"Yi"];
        [self.detailDict setObject:[rs stringForColumn:@"Ji"] forKey:@"Ji"];
        [self.detailDict setObject:[rs stringForColumn:@"Chong"] forKey:@"Chong"];
        [self.detailDict setObject:[rs stringForColumn:@"XingWest"] forKey:@"XingWest"];
        [self.detailDict setObject:[rs stringForColumn:@"TianGanDiZhiYear"] forKey:@"TianGanDiZhiYear"];
        [self.detailDict setObject:[rs stringForColumn:@"TianGanDiZhiMonth"] forKey:@"TianGanDiZhiMonth"];
        [self.detailDict setObject:[rs stringForColumn:@"TianGanDiZhiDay"] forKey:@"TianGanDiZhiDay"];
        [self.detailDict setObject:[rs stringForColumn:@"LJie"] forKey:@"LJie"];
        [self.detailDict setObject:[rs stringForColumn:@"GJie"] forKey:@"GJie"];
        [self.detailDict setObject:[rs stringForColumn:@"LYear"] forKey:@"LYear"];
        [self.detailDict setObject:[rs stringForColumn:@"ershiba"] forKey:@"ershiba"];
        [self.detailDict setObject:[rs stringForColumn:@"JianShen"] forKey:@"JianShen"];
        [self.detailDict setObject:[rs stringForColumn:@"XingEast"] forKey:@"XingEast"];
        [self.detailDict setObject:[rs stringForColumn:@"WuxingNaDay"] forKey:@"WuxingNaDay"];
        [self.detailDict setObject:[rs stringForColumn:@"ShenWei"] forKey:@"ShenWei"];
        [self.detailDict setObject:[rs stringForColumn:@"Taishen"] forKey:@"Taishen"];
        [self.detailDict setObject:[rs stringForColumn:@"PengZu"] forKey:@"PengZu"];
        [self.detailDict setObject:[rs stringForColumn:@"Suisha"] forKey:@"Suisha"];
    }
    [rs close];
    
    
    
    NSString *ershiBaID = self.detailDict[@"ershiba"];
    
    FMResultSet *ershibars = [db executeQuery:@"select * from ershiba where id = ?", ershiBaID];
    while ([ershibars next]) {
        
        [self.detailDict setObject:[ershibars stringForColumn:@"xingxiu"] forKey:@"xingxiu"];
    }
    
    
    NSMutableArray *arr11 = [NSMutableArray array];
    NSString *TGDZR = [NSString stringWithFormat:@"%@日",self.detailDict[@"TianGanDiZhiDay"]];
    FMResultSet *tgdzrs = [db executeQuery:@"select * from shichen where xri = ?", TGDZR];
    while ([tgdzrs next]) {
        NSString *lasStr = [NSString stringWithFormat:@"%@%@",[tgdzrs stringForColumn:@"shichen"],[tgdzrs stringForColumn:@"jixiong"]];
        [arr11 addObject:lasStr];
    }
    
    //NSLog(@"%@",arr11);
    
    self.detailDict[@"shichen"] = arr11;
    
    
    //NSLog(@"self.detailDict = %@",self.detailDict);
    
    [self.tableView reloadData];
}



-(NSString *)readyDatabase:(NSString *)dbName
{
    BOOL success;
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSError *error;
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory=[paths objectAtIndex:0];
    NSString *writableDBPath=[documentsDirectory stringByAppendingPathComponent:dbName];
    success=[fileManager fileExistsAtPath:writableDBPath];
    if(!success)
    {
        NSString *defaultDBPath=[[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:dbName];
        success=[fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
        if(!success)
        {
            NSLog(@"%@",[error localizedDescription]);
        }
    }
    return writableDBPath;
}

- (NSString *)GetChineseCalendarOfDate:(NSDate *)date {
    NSString *day,*month;
    NSCalendar *chineseCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *components = [chineseCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    
    month = ChineseMonths[components.month - 1];
    
    day = ChineseDays[components.day - 1];
    
    [self.detailDict setObject:[NSString stringWithFormat:@"%@%@",month,day] forKey:@"chineseDay"];
    
    return day;
}


-(void)weekStringFromDate:(NSDate *)date{
    
    NSArray *weeks=@[[NSNull null],@"星期天",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    NSCalendar *calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone=[[NSTimeZone alloc]initWithName:@"Asia/Beijing"];
    [calendar setTimeZone:timeZone];
    NSCalendarUnit calendarUnit=NSCalendarUnitWeekday;
    NSDateComponents *components=[calendar components:calendarUnit fromDate:date];
    [self.detailDict setObject:[weeks objectAtIndex:components.weekday] forKey:@"weekDay"];
}

- (NSDate *)getFormatDateWithDateString:(NSString *)dateString withFormatStyle:(NSString *)dateFormatStyle{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormatStyle];
    
    NSDate *date = [dateFormatter dateFromString:dateString];
    return  date;
}

@end
