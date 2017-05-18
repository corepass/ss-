//
//  FXHomeTableViewController.m
//  shensu
//
//  Created by shensu on 17/5/18.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "FXHomeTableViewController.h"
#import "FXHoneTableViewCell.h"
#import "FXHomeModel.h"
#import "FXWebViewController.h"
@interface FXHomeTableViewController ()
@property(strong,nonatomic) NSMutableArray * dataArray;
@end

@implementation FXHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * array = @[@{
        @"articleid": @216887,
        @"lotteryname": @"足彩十四场",
        @"title": @"[Samuel]胜负彩2017075期推荐：大黄蜂望“梅”止渴",
        @"addTime": @"0分钟前",
        @"articlepic": @"http://www.310win.com/Files/Article/article_636307146406888095.png"
    }, @{
        @"articleid": @216886,
        @"lotteryname": @"足彩十四场",
        @"title": @"胜负彩17074期盘口分析：莱斯特城低水利好",
        @"addTime": @"14分钟前",
        @"articlepic": @"http://www.310win.com/Files/Article/article_636307138189417662.jpg"
    }, @{
        @"articleid": @216884,
        @"lotteryname": @"福彩3D",
        @"title": @"福彩3D第2017131期预测：百位小区间出码",
        @"addTime": @"05-18 12:04",
        @"articlepic": @"http://www.310win.com/Files/Article/article_636307058457365620.png"
    }, @{
        @"articleid": @216883,
        @"lotteryname": @"福彩3D",
        @"title": @"福彩3D第2017131期预测：十位关注偶数码",
        @"addTime": @"05-18 12:03",
        @"articlepic": @"http://www.310win.com/Files/Article/article_636307058057848918.png"
    }, @{
        @"articleid": @216882,
        @"lotteryname": @"超级大乐透",
        @"title": @"大乐透第2017057期预测：第二区看好奇数",
        @"addTime": @"05-18 12:01",
        @"articlepic": @"http://www.310win.com/Files/Article/article_636307056746198615.png"
    }, @{
        @"articleid": @216881,
        @"lotteryname":@"超级大乐透",
        @"title": @"大乐透第2017057期预测：龙头小数码走强",
        @"addTime": @"05-18 12:00",
        @"articlepic": @"http://www.310win.com/Files/Article/article_636307056180229620.png"
    }, @{
        @"articleid": @216880,
        @"lotteryname": @"排列3",
        @"title": @"排列三第2017131期预测：和值会大幅下滑",
        @"addTime": @"05-18 11:54",
        @"articlepic": @"http://www.310win.com/Files/Article/article_636307052705011517.png"
    }, @{
        @"articleid": @216879,
        @"lotteryname": @"排列3",
        @"title": @"排列三第2017131期预测：百位大数码回暖",
        @"addTime": @"05-18 11:53",
        @"articlepic": @"http://www.310win.com/Files/Article/article_636307052106126465.png"
    }, @{
        @"articleid": @216878,
        @"lotteryname": @"足彩十四场",
        @"title": @"胜负彩第17073期开奖：瑞典超冷门频出 头奖仅1注",
        @"addTime": @"05-18 11:42",
        @"articlepic": @"http://www.310win.com/Files/Article/article_636307045703719219.png"
    }, @{
        @"articleid": @216877,
        @"lotteryname": @"竞彩让球胜平负",
        @"title": @"法乙2串1推荐：克莱蒙温和结尾 特鲁瓦拼胜利",
        @"addTime": @"05-18 11:38",
        @"articlepic": @"http://www.310win.com/Files/Article/article_636307043017862502.jpg"
    }, @{
        @"articleid": @216876,
        @"lotteryname": @"竞彩让球胜平负",
        @"title": @"[夏中超]法乙推荐：剑指冠军 斯特拉斯堡“兰”以阻挡",
        @"addTime": @"05-18 11:29",
        @"articlepic": @"http://www.310win.com/Files/Article/article_636307037797001332.png"
    }, @{
        @"articleid": @216875,
        @"lotteryname": @"竞彩让球胜平负",
        @"title": @"[步步为赢]法乙竞彩推荐：最后关头 欧塞尔摘星保级",
        @"addTime": @"05-18 11:25",
        @"articlepic": @"http://www.310win.com/Files/Article/article_636307035474313252.jpg"
    }, @{
        @"articleid": @216874,
        @"lotteryname": @"超级大乐透",
        @"title": @"大乐透第2017057期预测：和值走势有下降",
        @"addTime": @"05-18 11:16",
        @"articlepic": @"http://www.310win.com/Files/Article/article_636307029712755133.png"
    }, @{
        @"articleid": @216873,
        @"lotteryname": @"排列3",
        @"title": @"排列三第2017131期预测：心水推荐7 1 6",
        @"addTime": @"05-18 11:13",
        @"articlepic": @"http://www.310win.com/Files/Article/article_636307028434020887.png"
    }];
    self.dataArray = [FXHomeModel mj_objectArrayWithKeyValuesArray:array];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellindetifi = @"cell";
    FXHoneTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellindetifi];
    
    if (cell == nil ){
        cell = [[NSBundle mainBundle] loadNibNamed:@"FXHoneTableViewCell" owner:self options:nil].firstObject;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FXHomeModel * model = _dataArray[indexPath.row];
    FXWebViewController * wk = [[FXWebViewController alloc] init];
    wk.titleName = model.lotteryname;
    wk.accessUrl = [NSString stringWithFormat:@"http://client.310win.com/aspx/ArticleShow.aspx?articleid=%@",model.articleid];
    [self.navigationController pushViewController:wk animated:true];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath @{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath @{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath @{
    if (editingStyle == UITableViewCellEditingStyleDelete) @{
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) @{
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath @{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath @{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender @{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
