//
//  DuanziViewController.m
//  搞笑排行榜
//
//  Created by 叶英杰 on 9/12/16.
//  Copyright © 2016 叶英杰. All rights reserved.
//

#import "DuanziViewController.h"
#import "AFNetworking.h"
#import "YYModel.h"
#import "BaseModel.h"
#import "BaseCell.h"
#import "ShuaxinTableViewController.h"
#import "WXRefresh.h"

@class AFHTTPSessionManager;
@interface DuanziViewController ()<UITableViewDelegate, UITableViewDataSource>
{
   NSMutableArray *_dataArray;
    UIAlertController *alertCtrl;
     UIImageView *_refreshCountView; //刷新条数提示
    UILabel *_newCountLabel; //加在_refreshCountView

}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end


@implementation DuanziViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    
  
    [_tableView registerNib:[UINib nibWithNibName:@"BaseCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    self.tableView.estimatedRowHeight = 150; // 保障滑动流畅性？？
//    _tableView.backgroundColor = [UIColor clearColor];

    __weak typeof(self) wself = self;
    
    [_tableView addPullDownRefreshBlock:^{
        __strong typeof(self) strongSelf = wself;
        
        [strongSelf loadNewData];
        
    }];
    
    [_tableView addInfiniteScrollingWithActionHandler:^{
        __strong typeof(self) strongSelf = wself;
        
        [strongSelf loadMoreData];
    }];
    
    
    _refreshCountView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 5, kScreenWidth - 30, 50)];
    _refreshCountView.image = [UIImage imageNamed:@"login_greenBtn"];
    _refreshCountView.transform = CGAffineTransformMakeTranslation(0, -60);
    [self.view addSubview:_refreshCountView];
    
    UISwipeGestureRecognizer *swipe1 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(createScroll1:)];
    [self.view addGestureRecognizer:swipe1];
    swipe1.direction  = UISwipeGestureRecognizerDirectionLeft;



}
//       -------------视图滑动 - -- -- -- - -- -- - - -

-(void)createScroll1:(UISwipeGestureRecognizer *)swipe


{
    
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    
    
    
    NSArray *aryViewController = self.tabBarController.viewControllers;
    
    if (selectedIndex < aryViewController.count - 1) {
        
        UIView *fromView = [self.tabBarController.selectedViewController view];
        
        UIView *toView = [[self.tabBarController.viewControllers objectAtIndex:selectedIndex + 1] view];
   
      
        [UIView transitionFromView:fromView toView:toView duration:0.5f options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
            
            if (finished) {
                
                [self.tabBarController setSelectedIndex:selectedIndex + 1];
                
            }
            
        }];
        
    }
    
    
    
}





- (void)loadData{
    
    NSString *url =  @"http://xiaoliao.vipappsina.com/index.php/Api386/index/pad/0/sw/1/cid/joke/p/1/markId/0/date/";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSArray *array = responseObject[@"rows"];
        NSMutableArray *mArray = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            
            BaseModel *model = [BaseModel yy_modelWithJSON:dic];
          
            if ([model.ID isEqualToString:@"native_ad"]) {
                continue;
            }
            [mArray addObject:model];
        }
        
        
        _dataArray = [mArray mutableCopy];
        
        [_tableView reloadData];
        
        
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      
        
    }];
    
    
    
}

#pragma mark - tableView dataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    BaseCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"BaseCell" owner:self options:nil]lastObject];
    }
//        NSString *str =  [[NSUserDefaults standardUserDefaults]objectForKey:ksZan];
//      [_zanButton setImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
    cell.model = _dataArray[indexPath.row];
//    cell.baseTextLabel.font = [UIFont systemFontOfSize:18];
    
    
    
    
    
    
    
    UIButton *button = [cell viewWithTag:110];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BaseModel *model = _dataArray[indexPath.row];
    FontLabel  *label = [[FontLabel alloc]init];
    NSDictionary *attributes = @{ NSFontAttributeName : label.font};
    CGRect rect = [model.title boundingRectWithSize:CGSizeMake(kScreenWidth - 20, 10000) options:NSStringDrawingUsesLineFragmentOrigin  attributes:attributes context:nil];
    CGFloat height = rect.size.height;
    
    
    CGFloat imgHeight = model.pic ? model.pic_h : 0;

    
    return height + 40 + 70 + imgHeight;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return NO;
}

//下拉刷新
- (void)loadNewData{
    NSLog(@"刷新 新数据");
    
    
    NSString *url =  @"http://xiaoliao.vipappsina.com/index.php/Api386/index/pad/0/sw/1/cid/joke/p/1/markId/0/date/";
    
    
    //    NSString *url =  @"http://xiaoliao.vipappsina.com/index.php/Api386/index/pad/0/sw/1/cid/joke/lastTime";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSArray *array = responseObject[@"rows"];
        NSMutableArray *mArray = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            BaseModel *model = [BaseModel yy_modelWithJSON:dic];
            if ([model.ID isEqualToString:@"native_ad"]) {
                continue;
            }else{
                [mArray addObject:model];
            }
            
        }
        
        _dataArray = [mArray mutableCopy];
        
        [_tableView.pullToRefreshView stopAnimating];
        
        [_tableView reloadData];
        
        
        [UIView animateWithDuration:0.5 animations:^{
            _refreshCountView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 delay:1 options:UIViewAnimationOptionLayoutSubviews  animations:^{
                _refreshCountView.transform = CGAffineTransformMakeTranslation(0, -60);
            } completion:nil];
        }];
        
        _newCountLabel = [[UILabel alloc]initWithFrame:_refreshCountView.bounds];
        
        _newCountLabel.text = @"获取到最新16条段子，共64211条";
        _newCountLabel.textAlignment = NSTextAlignmentCenter;
        [_refreshCountView addSubview:_newCountLabel];
        
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
    
    
    
}

//上拉刷新

- (void)loadMoreData{
    NSLog(@"刷新更多数据");
    
    
    
    BaseModel *model = [[BaseModel alloc]init];
    model = _dataArray.lastObject;
    NSInteger a = model.cTime;
//    http://xiaoliao.vipappsina.com/index.php/Api386/index/pad/0/sw/1/cid/mm/lastTime/1472272661
    NSString *url = [NSString stringWithFormat:@"http://xiaoliao.vipappsina.com/index.php/Api386/index/pad/0/sw/1/cid/joke/lastTime/%li",a];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSLog(@"%@", responseObject);
        
        
        NSMutableArray *mArray = [NSMutableArray array];
        for (NSDictionary *dic in responseObject) {
            BaseModel *model = [BaseModel yy_modelWithJSON:dic];
            if ([model.ID isEqualToString:@"native_ad"]) {
                continue;
            }else{
                [mArray addObject:model];
            }
            
        }
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(_dataArray.count  , mArray.count)];
        [_dataArray insertObjects:[mArray copy] atIndexes:set];
        [_tableView.infiniteScrollingView stopAnimating];
        [_tableView reloadData];
        
        
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
    
    
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
