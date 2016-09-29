//
//  AppDelegate.m
//  搞笑排行榜1.0
//
//  Created by Mac on 16/8/14.
//  Copyright © 2016年 CXCK. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabBarController.h"
#import "LeftViewController.h"
#import "BaseNavController.h"
#import "MMDrawerController.h"
#import "UIViewController+MMDrawerController.h"
#define  kWeiboAuthDateKey @"kWeiboAuthDateKey"
//135066101 appkey
//f3fffd195ae6c6ebffc5cf72efdeae61 appsret

//171e806b45558  50ff7261d112f068b88e0aa92dfa6af4
@interface AppDelegate ()

@property(nonatomic,strong)UIView *nigView;
@end

@implementation AppDelegate
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:self selector:@selector(receiveNotifica) name:kMoomNoti object:nil];
        
        NSNotificationCenter *center2 = [NSNotificationCenter defaultCenter];
        [center2 addObserver:self selector:@selector(receiveNotifica2) name:kSunNoti object:nil];
  
        
    }
    return self;
}

- (void)receiveNotifica
{
    self.nigView.hidden = NO;
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"value",@"key", nil];
//    [[NSNotificationCenter defaultCenter]postNotificationName:kMoomNoti object:@"香皂" userInfo: dic];
}

- (void)receiveNotifica2
{
    self.nigView.hidden = YES;
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"value",@"key", nil];
//    [[NSNotificationCenter defaultCenter]postNotificationName:kSunNoti object:@"香皂" userInfo: dic];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    RootTabBarController *tab = [[RootTabBarController alloc]init];
    LeftViewController *leftVC  = [[LeftViewController alloc]init];
    
    BaseNavController *leftNavi=  [[ BaseNavController alloc]initWithRootViewController:leftVC];
    MMDrawerController *mmd = [[MMDrawerController alloc]initWithCenterViewController:tab leftDrawerViewController:leftNavi];
    
    mmd.maximumLeftDrawerWidth = 80;
    [mmd setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [mmd setCloseDrawerGestureModeMask: MMCloseDrawerGestureModeTapCenterView  ];
    
    
    [mmd setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        MMExampleDrawerVisualStateManager *manager = [MMExampleDrawerVisualStateManager sharedManager];
        MMDrawerControllerDrawerVisualStateBlock block = [manager drawerVisualStateBlockForDrawerSide:drawerSide];
        if (block) {
            block(drawerController,drawerSide,percentVisible);
        }
    }];
    
   
    
    
    
    
    
    
    self.window.rootViewController = mmd;
    
    
    self.nigView = [[UIView alloc] initWithFrame:self.window.bounds];
    self.nigView.userInteractionEnabled = NO;
   
    self.nigView.backgroundColor = [UIColor blackColor];
    NSString *a = [[NSUserDefaults standardUserDefaults]objectForKey:@"sunNight"];
    NSInteger flag = [a integerValue];
    if (flag==0) {
        self.nigView.hidden = NO;
    }
    else
    {
        self.nigView.hidden = YES;
    }
    self.nigView.alpha = 0.3;
    [self.window addSubview:self.nigView];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    __weibo = [[SinaWeibo alloc]initWithAppKey:@"135066101" appSecret:@"f3fffd195ae6c6ebffc5cf72efdeae61" appRedirectURI:@"http://www.baidu.com" andDelegate:self];
    
    
    ;
    
    
    return YES;
    
    
    
}

     
     
     
     
- (BOOL)loginWeibo{
    BOOL isAuth = [self loadData];
    if (isAuth==NO) {
        [__weibo logIn];
        NSLog(@"从未登录过微博");
        return NO;
    }
    else
    {
        NSLog(@"已经登录过微博%@",__weibo.accessToken);
        return YES;
    }
}
- (void)logoutWeibo
{
    [__weibo logOut];
}
-(void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:kWeiboAuthDateKey];
    
}
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"登录成功:%@",sinaweibo.accessToken);
    [self saveAuthData];
    
    NSLog(@"%@",NSHomeDirectory());
}
- (void)saveAuthData
{
    //用户令牌
    NSString *token = __weibo.accessToken;
    //用户的id  uid
    NSString *uid = __weibo.userID;
    //认证的有效期限 长期不使用，会导致
    NSDate *date = __weibo.expirationDate;
    // 使用属性列表，保存登录数据到本地
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = @{@"accessToken" :token,
                          @"uid":uid,
                          @"expirationDate":date};
    [userDef setObject:dic forKey:kWeiboAuthDateKey];
    
    [userDef synchronize];
    
    
    
    
}
- (BOOL)loadData
{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = [userDef objectForKey:kWeiboAuthDateKey];
    if (dic==nil) {
        //        NSLog(@"未登录过微博");
        return NO;
    }
    NSString *token =dic[@"accessToken"];
    NSString *uid =  dic[@"uid"];
    NSDate *date =dic[@"expirationDate"];
    if (token==nil||uid==nil||date==nil) {
        NSLog(@"登录信息有误");
        return NO;
    }
    
    __weibo.userID = uid;
    __weibo.accessToken = token;
    __weibo.expirationDate = date;
    return YES;
    
    
    
    
}


//#import <ShareSDK/ShareSDK.h>
//#import <ShareSDKUI/ShareSDK+SSUI.h>
//1
//2
//1
//2
//－.调用构造分享参数接口和分享的接口
//
//#pragma mark ---------分享----------
////这是分享按钮
//- (void)fxAction:(UIButton *)sender {
//    NSLog(@"分享");
//    //1、创建分享参数
//    //    NSArray* imageArray = @[[UIImage imageNamed:@"nihao.png"]];
//    
//    NSArray* imageArray =  @[[UIImage imageWithContentsOfFile:path]];
//    
//    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
//    if (imageArray) {
//        
//        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//        [shareParams SSDKSetupShareParamsByText:@"分享内容"
//                                         images:imageArray
//                                            url:[NSURL URLWithString:@"http://mob.com"]
//                                          title:@"分享标题"
//                                           type:SSDKContentTypeAuto];
//        //2、分享（可以弹出我们的分享菜单和编辑界面）
//        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
//                                 items:nil
//                           shareParams:shareParams
//                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
//                       
//                       switch (state) {
//                           case SSDKResponseStateSuccess:
//                           {
//                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                                   message:nil
//                                                                                  delegate:nil
//                                                                         cancelButtonTitle:@"确定"
//                                                                         otherButtonTitles:nil];
//                               [alertView show];
//                               break;
//                           }
//                           case SSDKResponseStateFail:
//                           {
//                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
//                                                                               message:[NSString stringWithFormat:@"%@",error]
//                                                                              delegate:nil
//                                                                     cancelButtonTitle:@"OK"
//                                                                     otherButtonTitles:nil, nil];
//                               [alert show];
//                               break;
//                           }
//                           default:
//                               break;
//                       }
//                   }
//         ];}
//}
//
//
//
//

//- (void)qqAction:(UIButton *)sender {
//    NSLog(@"QQ");
//    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformTypeQQ
//                                   onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
//                                       
//                                       //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
//                                       //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
//                                       associateHandler (user.uid, user, user);
//                                       NSLog(@"dd%@",user.rawData);
//                                       NSLog(@"dd%@",user.credential);
//                                       
//                                   }
//                                onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
//                                    
//                                    if (state == SSDKResponseStateSuccess)
//                                    {
//                                        
//                                    }
//                                    
//                                }];
//    
//}











- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
