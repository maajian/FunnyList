//
//  MoreViewController.m
//  搞笑排行榜1.0
//
//  Created by Mac on 16/8/14.
//  Copyright © 2016年 CXCK. All rights reserved.
//

#import "MoreViewController.h"
#import "modalViewController.h"
#import "AppDelegate.h"
#import "WebViewController.h"
#import "UIView+TYAlertView.h"
//171e806b45558  50ff7261d112f068b88e0aa92dfa6af4
//http://xiaoliao.vipappsina.com/index.php/Api386/appList
@interface MoreViewController ()<SinaWeiboDelegate,SinaWeiboRequestDelegate,UIAlertViewDelegate>
{
    NSString *name;
    NSURL *imageUrl;
    BOOL flag;
    UIView *view;
    UIAlertView *alertView;
//    BOOL isload;
}
@property (weak, nonatomic) IBOutlet UITableViewCell *loginTableCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *shoucangTableCell;

@property (weak, nonatomic) IBOutlet UITableViewCell *tuijianTableCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *guliwoTableCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *shareTableCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *fankuiTableCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *mianzeTableCell;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UIButton *sunNightButton;
@property (weak, nonatomic) IBOutlet UILabel *sizeLabel;

@end

@implementation MoreViewController
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(change)
//                                                    name:kLoad object:nil];
//    }
//    return self;
//}
//- (void)change
//{
//    isload = NO;
//    _userImageView.image = [UIImage imageNamed:@"cell_favo.png"];
//    _userLabel.text = @"登录/注册";
//}
 - (void)SunNightButton
{
    [_sunNightButton addTarget:self action:@selector(count) forControlEvents:UIControlEventTouchUpInside];
    if (flag ==YES) {
        [_sunNightButton setImage:[UIImage imageNamed:@"icon_moon.png"] forState:UIControlStateNormal];
       
    }
    else{
        [_sunNightButton setImage:[UIImage imageNamed:@"icon_sun.png"] forState:UIControlStateNormal];
                 }

}


- (void)count
{
    flag = !flag;
    if (flag ==YES) {
        [_sunNightButton setImage:[UIImage imageNamed:@"icon_moon.png"] forState:UIControlStateNormal];

        [[NSNotificationCenter defaultCenter]postNotificationName:kSunNoti object:nil ];
        NSString *str = [NSString stringWithFormat:@"%i",flag];
        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"sunNight"];
    
    }
    else{
        [_sunNightButton setImage:[UIImage imageNamed:@"icon_sun.png"] forState:UIControlStateNormal];
        
        [[NSNotificationCenter defaultCenter]postNotificationName:kMoomNoti object:nil];
        NSString *str = [NSString stringWithFormat:@"%i",flag];
        [[NSUserDefaults standardUserDefaults]setObject:str forKey:@"sunNight"];

    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *a = [[NSUserDefaults standardUserDefaults]objectForKey:@"sunNight"];
    NSInteger b = [a integerValue];
    if (b==0) {
        flag = NO;
    }
    else
    {
        flag = YES;
    }

//    isload = YES;
    [self SunNightButton];

//    [self createGrayView];
    UITapGestureRecognizer *guliTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(createWebView)];
    [self.guliwoTableCell addGestureRecognizer:guliTap];
    self.guliwoTableCell.userInteractionEnabled = YES   ;
    self.guliwoTableCell.multipleTouchEnabled = YES;



    UISwipeGestureRecognizer *swipe2 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(createScroll2:)];
    [self.view addGestureRecognizer:swipe2];
    
    NSLog(@"super = %@",self.view.nextResponder);
    
}
//       -------------视图滑动 - -- -- -- - -- -- - - -



-(void)createScroll2:(UISwipeGestureRecognizer *)swipe

{
    
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    
    
    
    if (selectedIndex > 0) {
        
        UIView *fromView = [self.tabBarController.selectedViewController view];
        
        UIView *toView = [[self.tabBarController.viewControllers objectAtIndex:selectedIndex - 1] view];
        
        [UIView transitionFromView:fromView toView:toView duration:0.5f options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
            
            if (finished) {
                
                [self.tabBarController setSelectedIndex:selectedIndex - 1];
                
            }
            
        }];
        
    }
    
    
}

- (void)createWebView
{
    WebViewController *web = [[WebViewController alloc]initWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    web.hidesBottomBarWhenPushed = YES;
    UIResponder *nextResponder = self.nextResponder;
    while (nextResponder) {
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            NSLog(@"yes");
            UINavigationController *nav = (UINavigationController *)nextResponder;
            [nav pushViewController:web animated:YES];
            break;
        }
        nextResponder = nextResponder.nextResponder;
    }
//    [self presentViewController:web animated:YES completion:nil];
}
//- (void)createGrayView
//{
//    view = [[UIView alloc]init];
//    view.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight-64);
//    view.backgroundColor = [UIColor blackColor];
//    view.alpha = 0;
//
//
//    
//    view.userInteractionEnabled=NO;
//    [self.navigationController.view addSubview:view];
//    
//}
//- (UIWindow *)lastWindow
//{
//    NSArray *windows = [UIApplication sharedApplication].windows;
//    for(UIWindow *window in [windows reverseObjectEnumerator]) {
//        
//        if ([window isKindOfClass:[UIWindow class]] &&
//            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
//            
//            return window;
//    }
//    
//    return [UIApplication sharedApplication].keyWindow;
//}
//---------------------------清除缓存---------------------

- (void)clearCache
{
    NSString *cache = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    [[NSFileManager defaultManager]removeItemAtPath:cache error:NULL];
}
- (void)readCacheSize
{
    NSUInteger size = [self getCacheData];
    
    double mbSize = size / 1024.0 / 1024.0;
    _sizeLabel.text = [NSString stringWithFormat:@"%.2fM", mbSize];
}
 - (NSUInteger)getCacheData
{
    NSUInteger size = 0;
    //1、简单方法
    //    NSUInteger size = [[SDImageCache sharedImageCache] getSize];
    //找到缓存路径
    NSString *cache = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Caches"];
    //文件枚举 获取当前路径下所有文件的属性
    NSDirectoryEnumerator *fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:cache];
    
    //拿到文件夹里面的所有文件
    for (NSString *fileName in fileEnumerator) {
        //获取所有文件的路径
        NSString *filePath = [cache stringByAppendingPathComponent:fileName];
        //获取所有文件的属性
        NSDictionary *dic = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:NULL];
        //计算每个文件的大小
        //计算总共文件的大小
        size += [dic fileSize];
    }
    
    return size;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1&&indexPath.row == 0) {
//        [self clearCache];
//        [self readCacheSize];
        [self createAlertView];
    }
    
}
- (void)createAlertView
{
   alertView = [[UIAlertView alloc]initWithTitle:@"清除缓存" message:@"清除缓存有助于节省空间，保留则可以浏览之前的图片速度更快，是否确定清除?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [self.view addSubview:alertView];
    [alertView show];
}
//- (void)login
//{
//    SinaWeibo *wb = kSinaWeiboObject;
//    
//    if ([wb isAuthValid]) {
//        
//    }
// 
//   
//}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [self clearCache];
        [self readCacheSize];
    }
   
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
    
 
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self readCacheSize];
    [self loadUserData];
}
- (void)loadUserData
{
    SinaWeibo *wb = kSinaWeiboObject;
    if ([wb isAuthValid]) {
        NSDictionary *dic = @{@"uid" : wb.userID};
        
        SinaWeiboRequest *request = [wb requestWithURL:@"users/show.json" params:[dic mutableCopy] httpMethod:@"GET" delegate:self];
        request.tag = 1;
    }
    
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    SinaWeibo *wb = kSinaWeiboObject;

    NSLog(@"result = %@",result);
    name = result[@"name"];
    imageUrl = result[@"profile_image_url"];
    if ([wb isLoggedIn]) {
        [_userImageView sd_setImageWithURL:imageUrl];
        _userLabel.text = name;

    }
    else{
        _userImageView.image = [UIImage imageNamed:@"cell_favo.png"];
        _userLabel.text = @"登录/注册";
    }
    
    
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
