//
//  ZhuanjiaTableViewController.m
//  shensu
//
//  Created by shensu on 17/5/18.
//  Copyright © 2017年 杨健. All rights reserved.
//

#import "ZhuanjiaTableViewController.h"
#import "ZhuanjiaTableViewCell.h"
#import "ZhuanjiaModel.h"
@interface ZhuanjiaTableViewController ()
@property(strong,nonatomic) NSMutableArray * dataArray;
@end

@implementation ZhuanjiaTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * array = @[@{
        @"rowindex": @0,
        @"poster": @{
            @"userId": @2944557,
            @"name": @"足彩稻草人",
            @"avatar": @"http://dx1.310win.cn/files/recommend/20160823141941140.png"
        },
        @"lastTenStatusText": @"近30天：119中85",
        @"recommendCounts": @3,
        @"dataInfo": @[@{
            @"nameText": @"月命中",
            @"dataText": @"71%"
        }, @{
            @"nameText": @"月盈利",
            @"dataText": @"106%"
        }]
    }, @{
        @"rowindex": @1,
        @"poster": @{
            @"userId": @2994479,
            @"name": @"西班牙德比",
            @"avatar": @"http://www.310win.com/files/2016/8/20160822172500433.png"
        },
        @"lastTenStatusText": @"近30天：72中51",
        @"recommendCounts": @1,
        @"dataInfo": @[@{
            @"nameText": @"月命中",
            @"dataText": @"71%"
        }, @{
            @"nameText": @"月盈利",
            @"dataText": @"111%"
        }]
    }, @{
        @"rowindex": @2,
        @"poster": @{
            @"userId": @3114814,
            @"name": @"372596379",
            @"avatar": @"http://dx1.310win.cn/files/recommend/20170508113633854.png"
        },
        @"lastTenStatusText": @"近30天：149中104",
        @"recommendCounts": @2,
        @"dataInfo": @[@{
            @"nameText": @"月命中",
            @"dataText": @"70%"
        }, @{
            @"nameText": @"月盈利",
            @"dataText": @"110%"
        }]
    }, @{
        @"rowindex": @3,
        @"poster": @{
            @"userId": @2958870,
            @"name": @"赢盘大师",
            @"avatar": @"http://dx1.310win.cn/files/recommend/20161201131136383.png"
        },
        @"lastTenStatusText": @"近30天：65中45",
        @"recommendCounts": @0,
        @"dataInfo": @[@{
            @"nameText": @"月命中",
            @"dataText": @"69%"
        }, @{
            @"nameText": @"月盈利",
            @"dataText": @"103%"
        }]
    }, @{
        @"rowindex": @4,
        @"poster": @{
            @"userId": @2997021,
            @"name": @"2997021",
            @"avatar": @"http://dx1.310win.cn/files/recommend/20170411125316155.png"
        },
        @"lastTenStatusText": @"近30天：117中81",
        @"recommendCounts": @0,
        @"dataInfo": @[@{
            @"nameText": @"月命中",
            @"dataText": @"69%"
        }, @{
            @"nameText": @"月盈利",
            @"dataText": @"107%"
        }]
    }, @{
        @"rowindex": @5,
        @"poster": @{
            @"userId": @2993758,
            @"name": @"让球王子",
            @"avatar": @"http://dx1.310win.cn/files/recommend/20170515043004251.png"
        },
        @"lastTenStatusText": @"近30天：61中42",
        @"recommendCounts": @2,
        @"dataInfo": @[@{
            @"nameText": @"月命中",
            @"dataText": @"69%"
        }, @{
            @"nameText": @"月盈利",
            @"dataText": @"105%"
        }]
    }, @{
        @"rowindex": @6,
        @"poster": @{
            @"userId": @2946771,
            @"name": @"红单变变变",
            @"avatar": @"http://dx1.310win.cn/files/recommend/20160902003119088.png"
        },
        @"lastTenStatusText": @"近30天：73中50",
        @"recommendCounts": @3,
        @"dataInfo": @[@{
            @"nameText": @"月命中",
            @"dataText": @"68%"
        }, @{
            @"nameText": @"月盈利",
            @"dataText": @"110%"
        }]
    }, @{
        @"rowindex": @7,
        @"poster": @{
            @"userId": @2945121,
            @"name": @"2945121",
            @"avatar": @"http://dx1.310win.cn/files/recommend/20161004023704046.png"
        },
        @"lastTenStatusText": @"近30天：123中84",
        @"recommendCounts": @2,
        @"dataInfo": @[@{
            @"nameText": @"月命中",
            @"dataText": @"68%"
        }, @{
            @"nameText": @"月盈利",
            @"dataText": @"108%"
        }]
    }, @{
        @"rowindex": @8,
        @"poster": @{
            @"userId": @3097046,
            @"name": @"蓝天yy",
            @"avatar": @"http://dx1.310win.cn/files/recommend/20170417123112861.png"
        },
        @"lastTenStatusText": @"近30天：68中46",
        @"recommendCounts": @0,
        @"dataInfo": @[@{
            @"nameText": @"月命中",
            @"dataText": @"68%"
        }, @{
            @"nameText": @"月盈利",
            @"dataText": @"101%"
        }]
        },@{
            @"rowindex": @18,
            @"poster": @{
                @"userId": @3093990,
                @"name": @"亚盘老司机",
                @"avatar": @"http://dx1.310win.cn/files/recommend/20170430045008407.png"
            },
            @"lastTenStatusText": @"近30天：118中51",
            @"recommendCounts": @2,
            @"dataInfo": @[@{
                @"nameText": @"月命中",
                @"dataText": @"43%"
            }, @{
                @"nameText": @"月盈利",
                @"dataText": @"114%"
            }]
        }, @{
            @"rowindex": @19,
            @"poster": @{
                @"userId": @3040746,
                @"name": @"老副班长",
                @"avatar": @"http://dx1.310win.cn/files/recommend/20170304181026241.png"
            },
            @"lastTenStatusText": @"近30天：103中38",
            @"recommendCounts": @5,
            @"dataInfo": @[@{
                @"nameText": @"月命中",
                @"dataText": @"37%"
            }, @{
                @"nameText": @"月盈利",
                @"dataText": @"113%"
            }]
        }];
    self.dataArray = [ZhuanjiaModel mj_objectArrayWithKeyValuesArray:array];
    
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
    ZhuanjiaTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellindetifi];
    
    if (cell == nil ){
        cell = [[NSBundle mainBundle] loadNibNamed:@"ZhuanjiaTableViewCell" owner:self options:nil].firstObject;
    }
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     self.tabBarController.selectedIndex = 1;
    [self.navigationController popViewControllerAnimated:false];
   

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
