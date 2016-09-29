//
//  modalViewController.m
//  搞笑排行榜1.0
//
//  Created by mac10 on 16/9/12.
//  Copyright © 2016年 CXCK. All rights reserved.
//

#import "modalViewController.h"
#import "AppDelegate.h"
#import "UIView+TYAlertView.h"
@interface modalViewController ()
{
    BOOL flag;
}
@property (weak, nonatomic) IBOutlet UIButton *qqImageButton;
@property (weak, nonatomic) IBOutlet UIButton *weiboImageButton;
@property (weak, nonatomic) IBOutlet UIButton *dagouImageButton;

@end

@implementation modalViewController
- (IBAction)qqButtonAction:(id)sender {
    
}
- (IBAction)weiboImageButtonAction:(id)sender {
}
- (IBAction)logoutAction:(id)sender {
    SinaWeibo *wb = kSinaWeiboObject;
    [wb logOut];
//    [[NSNotificationCenter defaultCenter]postNotificationName:kLoad object:nil];
//    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createButton
{
    
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 50, 20);
    [leftButton setTitle:@"返回" forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = item2;
}

- (void)leftAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    flag = YES;
    self.navigationItem.leftBarButtonItem.customView.hidden = YES;
    self.navigationItem.rightBarButtonItem.customView.hidden = YES;
    [self createButton];
    self.view.backgroundColor = [UIColor whiteColor];
    [_qqImageButton setBackgroundImage:[UIImage imageNamed:@"icon_qqapp@2x"] forState:UIControlStateNormal];
    [_weiboImageButton setBackgroundImage:[UIImage imageNamed:@"icon_weibo@2x"] forState:UIControlStateNormal];
    [_weiboImageButton addTarget:self action:@selector(loginWeibo) forControlEvents:UIControlEventTouchUpInside];
    
    [self dagouButton];
//    BOOL login = [self loginWeibo];
//    if (login) {
//        [self loadUserData];
//    }
//    
    // Do any additional setup after loading the view from its nib.
}

- (void)dagouButton
{
    [ _dagouImageButton addTarget:self action:@selector(count) forControlEvents:UIControlEventTouchUpInside];
    if (flag==YES) {
        [_dagouImageButton setBackgroundImage:[UIImage imageNamed:@"com_btn_checked"] forState:UIControlStateNormal];
    }
    else
    {
        [_dagouImageButton setBackgroundImage:[UIImage imageNamed:@"com_btn_check"] forState:UIControlStateNormal];
    }
   
}
- (void)count
{
    flag = !flag;
    if (flag==YES) {
        [_dagouImageButton setBackgroundImage:[UIImage imageNamed:@"com_btn_checked"] forState:UIControlStateNormal];
         
    }
    else
    {
        [_dagouImageButton setBackgroundImage:[UIImage imageNamed:@"com_btn_check"] forState:UIControlStateNormal];

    }
}


-(BOOL)loginWeibo
{
    SinaWeibo *weibo = kSinaWeiboObject;
    if (flag==YES) {
         [weibo logIn];
        return YES;
    }
    return NO;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
//    [self.navigationController popViewControllerAnimated:YES];
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
