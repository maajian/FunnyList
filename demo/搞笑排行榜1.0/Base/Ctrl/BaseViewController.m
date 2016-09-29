//
//  BaseViewController.m
//  搞笑排行榜
//
//  Created by 叶英杰 on 9/12/16.
//  Copyright © 2016 叶英杰. All rights reserved.
//

#import "BaseViewController.h"
#import "ShuaxinTableViewController.h"

@interface BaseViewController ()
{

    UIAlertController *alertCtrl;
}


@end

@implementation BaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 40, 40);
    [rightButton setBackgroundImage:[UIImage imageNamed:@"navCal"] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    self.navigationItem.rightBarButtonItem = item1;
    
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 20, 20);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"browser_bookmark"] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = item2;
    
    
    
    
    
}




- (void)rightAction{
    alertCtrl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet ];
    UIAlertAction *actio1 = [UIAlertAction actionWithTitle:@"继续阅读" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertCtrl addAction:actio1];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"查看书签" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ShuaxinTableViewController *shuaxin = [[ShuaxinTableViewController alloc]init];
        [self.navigationController pushViewController:shuaxin    animated:YES];
        self.tabBarController.tabBar.hidden = YES;
    }];
    [alertCtrl addAction:action2];
    
    
    
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertCtrl addAction:action3];
    
    [self presentViewController:alertCtrl animated:YES completion:nil];

    
    
}


- (void)leftAction{
    
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
    
    
    
    
    
    
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
