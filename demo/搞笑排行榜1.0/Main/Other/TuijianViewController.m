//
//  TuijianViewController.m
//  搞笑排行榜1.0
//
//  Created by mac10 on 16/9/18.
//  Copyright © 2016年 CXCK. All rights reserved.
//

#import "TuijianViewController.h"
#import "AFNetworking.h"
//#import "AFHTTPSessionManager.h"
#import "TuijianModel.h"
#import "TuijianTableViewCell.h"
#import "YYModel.h"
#import "TuijianCellLayout.h"
#import "TuijianWebViewController.h"
//http://xiaoliao.vipappsina.com/index.php/Api386/appList
@interface TuijianViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *dataArray;
}
@end

@implementation TuijianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem.customView.hidden = YES;
    self.navigationItem.rightBarButtonItem.customView.hidden = YES;
    [self loadTuijianData];
    [self createButton];
    [self createTableView];
//    [[NSBundle mainBundle]loadNibNamed:@"TuijianTableViewCell" owner:self options:nil];
    // Do any additional setup after loading the view.
}
 - (void)createButton
{
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 20, 20);
    [rightButton setBackgroundImage:[UIImage imageNamed:@"shuaxin"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = item;
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20, 20);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"egopv_left"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = item2;
}
                             
- (void)rightAction
                             {
                                 
                             }
- (void)leftAction
                             {
                                 [self dismissViewControllerAnimated:YES completion:nil];
                             }
 - (void)loadTuijianData
{
    NSString *urlString = @"http://xiaoliao.vipappsina.com/index.php/Api386/appList";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject!=nil) {
            NSArray *array1 = [[NSArray alloc]init];
            array1 = responseObject;
            NSMutableDictionary *dic  = [[NSMutableDictionary alloc]init];
            [dic setValue:array1 forKey:@"key"];
           
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *plistPath1= [paths objectAtIndex:0];
            NSString *fileName =  [plistPath1 stringByAppendingPathComponent:@"tuijian.plist"];
            NSFileManager *fm = [NSFileManager defaultManager];
            if ([fm createFileAtPath:fileName contents:nil attributes:nil]==YES ) {
                [dic writeToFile:fileName atomically:YES];
                NSLog(@"app推荐文件写入成功");
            }
            [self loadData];
            [_tableView reloadData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"错误为%@",error);
    }];

    
}
- (void)loadData
{
    dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    NSString *home = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/tuijian.plist"];
    NSDictionary *cityDic = [NSDictionary dictionaryWithContentsOfFile:home];
    NSArray *tuijianArray = [[NSArray alloc]init];
    tuijianArray = cityDic[@"key"];
    if (dataArray ==nil) {
        dataArray = [[NSMutableArray alloc]init];
    }
    for (NSDictionary *dic1 in tuijianArray) {
        TuijianModel *model = [TuijianModel yy_modelWithJSON:dic1];
        [dataArray addObject:model];
    }
}
- (void)createTableView
{
    _tableView = [[ UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView .dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView registerNib:[UINib nibWithNibName:@"TuijianTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"tuijiancell"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count  ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath

{
    TuijianTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tuijiancell"];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tableView:didSelectRowAtIndexPath:)];
//    [cell addGestureRecognizer:tap];
    
    TuijianModel *model = dataArray[indexPath.row];
    [cell setModel:model];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TuijianModel *model = dataArray [indexPath.row];
    TuijianCellLayout *layout = [TuijianCellLayout layoutWithTuijianModel:model];
    return layout.cellHeight;
  
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell1 = [tableView cellForRowAtIndexPath:indexPath];
      TuijianModel *model = dataArray[indexPath.row];
    NSURL *url = model.clickURL;
    TuijianWebViewController *web = [[TuijianWebViewController alloc]initWithURL:url];
    [self presentViewController:web animated:YES completion:nil];
  
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
