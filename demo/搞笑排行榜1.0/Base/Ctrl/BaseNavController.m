//
//  BaseNavController.m
//  搞笑排行榜
//
//  Created by 叶英杰 on 9/12/16.
//  Copyright © 2016 叶英杰. All rights reserved.
//

#import "BaseNavController.h"

@interface BaseNavController ()

@end

@implementation BaseNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"login_greenBtn"] forBarMetrics:UIBarMetricsDefault];
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName : [UIFont boldSystemFontOfSize:20],
                                 NSForegroundColorAttributeName : [UIColor whiteColor]
                                 
                                 };
    self.navigationBar.titleTextAttributes = attributes;
    
    
    self.navigationBar.translucent = NO;
    
}

//状态栏字体颜色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
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
