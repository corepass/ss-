//
//  FXWeatherController.m
//  FDCalendarDemo
//
//  Created by 杨健 on 2016/12/1.
//  Copyright © 2016年 fergusding. All rights reserved.
//

#import "FXNLViewController.h"
#import "NSString+Extension.h"
#import "FXShiChenViewCell.h"
#import "UIBarButtonItem+Exstion.h"
#import "TitleButton.h"
#import "FMDB.h"

@interface FXNLViewController ()<UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *nlDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *weekDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *estxzLabel;
@property (weak, nonatomic) IBOutlet UILabel *westxzLabel;
@property (weak, nonatomic) IBOutlet UILabel *yiLabel;
@property (weak, nonatomic) IBOutlet UILabel *jiLabel;
@property (weak, nonatomic) IBOutlet UILabel *xxLabel;
@property (weak, nonatomic) IBOutlet UILabel *jianshenLabel;


@property (weak, nonatomic) IBOutlet UIButton *wxBtn;
@property (weak, nonatomic) IBOutlet UIButton *fsBtn;
@property (weak, nonatomic) IBOutlet UIButton *xsBtn;
@property (weak, nonatomic) IBOutlet UIButton *congshaBtn;

@property (weak, nonatomic) IBOutlet UIButton *yingBtn;
@property (weak, nonatomic) IBOutlet UIButton *csBtn;
@property (weak, nonatomic) IBOutlet UIButton *yangBtn;

@property (weak, nonatomic) IBOutlet UIButton *tsBtn;
@property (weak, nonatomic) IBOutlet UIButton *pzBtn;

@property (nonatomic,strong)UIDatePicker *datePicker;
@property (nonatomic,strong)UIView *coverView;
@property (nonatomic,strong)UIToolbar *toolBar;
@property (nonatomic,strong)TitleButton *titleBtn;


@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *allBtn;

#define kbgColor [UIColor colorWithRed:218 / 255.0 green:76 /255.0 blue:92/255.0 alpha:1]
#define ktitltFont [UIFont systemFontOfSize:15]

#define ChineseMonths @[@"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",@"九月", @"十月", @"冬月", @"腊月"]
#define ChineseDays @[@"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",@"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十", @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十"]
@end

@implementation FXNLViewController

static NSString  *cellID = @"FXShiChenViewCell";

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backImage_w"] style:UIBarButtonItemStyleDone target:self action:@selector(rightClick)];
    self.navigationItem.leftBarButtonItem = right;
}
-(void)rightClick{
    [self dismissViewControllerAnimated:YES completion:nil];
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
        _coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 44+216+40, kScreenW, kScreenH - 44 -216 - 40)];
        
        _coverView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.5];
    }
    return _coverView;
}

-(void)cancel{
    self.titleBtn.selected = NO;
    [self.datePicker removeFromSuperview];
    [self.toolBar removeFromSuperview];
    [self.coverView removeFromSuperview];
}



- (void)doneClick{
    [self cancel];
    self.titleBtn.selected = NO;
   
    NSLog(@"%@",self.datePicker.date);
    [self selectedDate:self.datePicker.date];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"FXShiChenViewCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    
    TitleButton *btn = [[TitleButton alloc]init];
    [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = btn;
    self.titleBtn = btn;
    
    
    for (UIButton *btn in self.allBtn) {
        btn.titleLabel.numberOfLines = 0;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    [self setupUI];
}


- (void)setNlDict:(NSMutableDictionary *)nlDict{
    _nlDict = nlDict;
}

- (void)setupUI{
    
    NSString *titleStr = self.nlDict[@"selectedDate"];
    NSMutableString *lastStr = [NSMutableString stringWithString:titleStr];
    
    
    NSString *monthStr = [lastStr substringWithRange:NSMakeRange(5, 2)];
    
    NSString *dayStr = [lastStr substringWithRange:NSMakeRange(8, 2)];
    
    BOOL monthFirst = NO;
    if ([monthStr hasPrefix:@"0"]) {
        [lastStr replaceCharactersInRange:NSMakeRange(5, 1) withString:@""];
        monthFirst = YES;
    }
    
    if ([dayStr hasPrefix:@"0"]) {
        [lastStr replaceCharactersInRange:NSMakeRange(monthFirst?7:8, 1) withString:@""];
    }
    
    [self.titleBtn setTitle:lastStr forState:UIControlStateNormal];
    self.xxLabel.text = self.nlDict[@"xingxiu"];
    self.jianshenLabel.text = [NSString stringWithFormat:@"%@日",self.nlDict[@"JianShen"]];
    self.yiLabel.text = self.nlDict[@"Yi"];
    self.jiLabel.text = self.nlDict[@"Ji"];
    self.westxzLabel.text = [NSString stringWithFormat:@"西方星座 %@",self.nlDict[@"XingWest"]];
    self.nlDateLabel.text = self.nlDict[@"chineseDay"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImge:@"cancel" selectedIcon:@"cancel" target:self andSEL:@selector(dismiss)];
    
    self.westxzLabel.attributedText = [NSString renderText:self.westxzLabel.text targetStr:@"西方星座" font:[UIFont systemFontOfSize:14] andColor:kbgColor];
    
    NSString *estStr = self.nlDict[@"XingEast"];
    NSRange range = [estStr rangeOfString:@"-"];
    NSString *newStr = nil;
    if (range.location != NSNotFound) {
        newStr = [estStr substringToIndex:range.location];
    }
    self.estxzLabel.text = [NSString stringWithFormat:@"东方星座 %@",newStr?newStr:estStr];
    self.estxzLabel.attributedText = [NSString renderText:self.estxzLabel.text targetStr:@"东方星座" font:[UIFont systemFontOfSize:14] andColor:kbgColor];
    
    self.weekDateLabel.text = [NSString stringWithFormat:@"%@%@年 %@月 %@日 %@ %@",self.nlDict[@"TianGanDiZhiYear"],self.nlDict[@"LYear"],self.nlDict[@"TianGanDiZhiMonth"],self.nlDict[@"TianGanDiZhiDay"],self.nlDict[@"weekDay"],self.nlDict[@"Weekday"]];
    
    NSString *wxStr = [NSString stringWithFormat:@"五行\n%@",self.nlDict[@"WuxingNaDay"]];
    [self.wxBtn setTitle:wxStr forState:UIControlStateNormal];
    [self.wxBtn setAttributedTitle:[NSString renderText:wxStr targetStr:@"五行" font:ktitltFont andColor:kbgColor] forState:UIControlStateNormal];
    
    [self rendBtnWithBtn:self.wxBtn andTargetStr:@"五行"];
    [self rendBtnWithBtn:self.tsBtn andTargetStr:@"今日胎神"];
    [self rendBtnWithBtn:self.pzBtn andTargetStr:@"彭祖百忌"];
    [self rendBtnWithBtn:self.congshaBtn andTargetStr:@"岁煞"];
    
    [self getShenWithBtn:self.xsBtn targetStr:@"喜神"];
    [self getShenWithBtn:self.fsBtn targetStr:@"福神"];
    [self getShenWithBtn:self.yingBtn targetStr:@"阴贵"];
    [self getShenWithBtn:self.yangBtn targetStr:@"阳贵"];
    [self getShenWithBtn:self.csBtn targetStr:@"财神"];
}


-(void)btnclick:(UIButton *)btn{
    btn.selected = !btn.selected;
    [self.view addSubview:self.datePicker];
    [self.view addSubview:self.toolBar];
    [self.view addSubview:self.coverView];
}

-(void)dismiss{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void )getShenWithBtn:(UIButton *)button targetStr:(NSString *)destr{
    
    NSString *shenweiStr = self.nlDict[@"ShenWei"];
    NSRange range = [shenweiStr rangeOfString:destr];
    
    NSString *lastStr = [shenweiStr substringWithRange:NSMakeRange(range.location + 3,2)];
    NSString *titleStr = [NSString stringWithFormat:@"%@\n%@",destr,lastStr];
    
    [button setTitle:titleStr forState:UIControlStateNormal];
    [button setAttributedTitle:[NSString renderText:titleStr targetStr:destr font:ktitltFont andColor:kbgColor] forState:UIControlStateNormal];
}


- (void)rendBtnWithBtn:(UIButton *)button andTargetStr:(NSString *)tagStr{
    
    NSString *titleStr = nil;
    if ([tagStr isEqualToString:@"五行"]) {
        titleStr = [NSString stringWithFormat:@"%@\n%@",tagStr,self.nlDict[@"WuxingNaDay"]];
    }else if ([tagStr isEqualToString:@"今日胎神"]){
        NSString *taishenStr = self.nlDict[@"Taishen"];
        NSRange range = [taishenStr rangeOfString:@"停留"];
       NSString *newStr = [taishenStr substringToIndex:range.location];
        
        titleStr = [NSString stringWithFormat:@"%@\n%@",tagStr,newStr];
    }else if ([tagStr isEqualToString:@"岁煞"]){
        titleStr = [NSString stringWithFormat:@"%@\n%@",tagStr,self.nlDict[@"Suisha"]];
    }else if ([tagStr isEqualToString:@"彭祖百忌"]){
        titleStr = [NSString stringWithFormat:@"%@\n%@",tagStr,self.nlDict[@"PengZu"]];
    }
    
    [button setTitle:titleStr forState:UIControlStateNormal];
    [button setAttributedTitle:[NSString renderText:titleStr targetStr:tagStr font:ktitltFont andColor:kbgColor] forState:UIControlStateNormal];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *arr = self.nlDict[@"shichen"];
    
    return arr.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FXShiChenViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    NSArray *arr = self.nlDict[@"shichen"];
    cell.titleName = arr[indexPath.row];
    return cell;
    
}

- (NSDate *)getFormatDateWithDateString:(NSString *)dateString withFormatStyle:(NSString *)dateFormatStyle{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormatStyle];
    
    NSDate *date = [dateFormatter dateFromString:dateString];
    return  date;
}


- (void)selectedDate:(NSDate *)selectedDate{
    
    [self GetChineseCalendarOfDate:selectedDate];
    
    [self weekStringFromDate:selectedDate];
    
    NSString *titleStr = [self stringFromDate:selectedDate];
    self.nlDict[@"selectedDate"] = titleStr;
    
    [self.titleBtn setTitle:titleStr forState:UIControlStateNormal];
    
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //每周的第一天从星期一开始
    [calendar setFirstWeekday:1];
    NSDateComponents *comps2 = [calendar components:NSCalendarUnitWeekOfYear fromDate:selectedDate];
    
    [self.nlDict setObject:[NSString stringWithFormat:@"第%ld周",comps2.weekOfYear] forKey:@"Weekday"];
    
    
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
        lastStr = [NSString stringWithFormat:@"%@/%@/%@",yearStr,monthStr,dayStr];
    }
    
    
    if (!newMonthStr && !newDayStr) {
        lastStr = selectedDay;
    }
    
    NSString *dayNum = newDayStr ? newDayStr : dayStr;
    [self.nlDict setObject:dayNum forKey:@"dayNum"];
    
    
    NSString *dbPath =[self readyDatabase:@"main.sqlite"];
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    [db open];
    
    FMResultSet *rs = [db executeQuery:@"select * from lunar where GregorianDateTime = ?", lastStr];
    
    while ([rs next]) {
        [self.nlDict setObject:[rs stringForColumn:@"Yi"] forKey:@"Yi"];
        [self.nlDict setObject:[rs stringForColumn:@"Ji"] forKey:@"Ji"];
        [self.nlDict setObject:[rs stringForColumn:@"Chong"] forKey:@"Chong"];
        [self.nlDict setObject:[rs stringForColumn:@"XingWest"] forKey:@"XingWest"];
        [self.nlDict setObject:[rs stringForColumn:@"TianGanDiZhiYear"] forKey:@"TianGanDiZhiYear"];
        [self.nlDict setObject:[rs stringForColumn:@"TianGanDiZhiMonth"] forKey:@"TianGanDiZhiMonth"];
        [self.nlDict setObject:[rs stringForColumn:@"TianGanDiZhiDay"] forKey:@"TianGanDiZhiDay"];
        [self.nlDict setObject:[rs stringForColumn:@"LJie"] forKey:@"LJie"];
        [self.nlDict setObject:[rs stringForColumn:@"GJie"] forKey:@"GJie"];
        [self.nlDict setObject:[rs stringForColumn:@"LYear"] forKey:@"LYear"];
        [self.nlDict setObject:[rs stringForColumn:@"ershiba"] forKey:@"ershiba"];
        [self.nlDict setObject:[rs stringForColumn:@"JianShen"] forKey:@"JianShen"];
        [self.nlDict setObject:[rs stringForColumn:@"XingEast"] forKey:@"XingEast"];
        [self.nlDict setObject:[rs stringForColumn:@"WuxingNaDay"] forKey:@"WuxingNaDay"];
        [self.nlDict setObject:[rs stringForColumn:@"ShenWei"] forKey:@"ShenWei"];
        [self.nlDict setObject:[rs stringForColumn:@"Taishen"] forKey:@"Taishen"];
        [self.nlDict setObject:[rs stringForColumn:@"PengZu"] forKey:@"PengZu"];
        [self.nlDict setObject:[rs stringForColumn:@"Suisha"] forKey:@"Suisha"];
    }
    [rs close];
    
    
    
    NSString *ershiBaID = self.nlDict[@"ershiba"];
    
    FMResultSet *ershibars = [db executeQuery:@"select * from ershiba where id = ?", ershiBaID];
    while ([ershibars next]) {
        
        [self.nlDict setObject:[ershibars stringForColumn:@"xingxiu"] forKey:@"xingxiu"];
    }
    
    
    NSMutableArray *arr11 = [NSMutableArray array];
    NSString *TGDZR = [NSString stringWithFormat:@"%@日",self.nlDict[@"TianGanDiZhiDay"]];
    FMResultSet *tgdzrs = [db executeQuery:@"select * from shichen where xri = ?", TGDZR];
    while ([tgdzrs next]) {
        NSString *lasStr = [NSString stringWithFormat:@"%@%@",[tgdzrs stringForColumn:@"shichen"],[tgdzrs stringForColumn:@"jixiong"]];
        [arr11 addObject:lasStr];
    }
    
    NSLog(@"%@",arr11);
    
    self.nlDict[@"shichen"] = arr11;
    
    
    NSLog(@"self.nlDict = %@",self.nlDict);
    
    [self setupUI];
    
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
    
    [self.nlDict setObject:[NSString stringWithFormat:@"%@%@",month,day] forKey:@"chineseDay"];
    
    return day;
}
-(void)weekStringFromDate:(NSDate *)date{
    
    NSArray *weeks=@[[NSNull null],@"星期天",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    NSCalendar *calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSTimeZone *timeZone=[[NSTimeZone alloc]initWithName:@"Asia/Beijing"];
    [calendar setTimeZone:timeZone];
    NSCalendarUnit calendarUnit=NSCalendarUnitWeekday;
    NSDateComponents *components=[calendar components:calendarUnit fromDate:date];
    [self.nlDict setObject:[weeks objectAtIndex:components.weekday] forKey:@"weekDay"];
}

- (NSString *)stringFromDate:(NSDate *)date {
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy年MM月dd日"];
    NSString *str = [formater stringFromDate:date];
    return str;
}


@end
