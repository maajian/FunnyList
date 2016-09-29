//
//  RootTabBarController.m
//  搞笑排行榜
//
//  Created by 叶英杰 on 9/12/16.
//  Copyright © 2016 叶英杰. All rights reserved.
//

#import "RootTabBarController.h"

@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createCustomTabBar];
        [self createSubControllers];
    }
    return self;
}


- (void)createSubControllers{
    
    
    NSArray *storyboardNames = @[@"duanzi", @"picture", @"wuyu", @"video", @"More"];
    NSMutableArray *mArray = [NSMutableArray array];
    
    for (NSString *sbName in storyboardNames) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:sbName bundle:nil];
        
        UINavigationController *nav = [sb instantiateInitialViewController];
        [mArray addObject:nav];
    }
    
    self.viewControllers = [mArray copy];
    
    
}



- (void)createCustomTabBar{
    
    
    for (UIView *subView in self.tabBar.subviews) {
        Class buttonClass = NSClassFromString(@"UITabBarButton");
        if ([subView isKindOfClass:buttonClass]) {
            [subView removeFromSuperview];
        }
    }
    
    CGFloat buttonWidth = kScreenWidth / 5;
    NSArray *imageArray = @[@"toolbar_fav_empty",
                            @"Icon-Photo",
                            @"tab_smile",
                            @"Icon-Video",
                            @"bar_more"
                            ];
    
    NSArray *titleArray = @[@"段子",
                            @"趣图",
                            @"物语",
                            @"视频",
                            @"更多"
                            ];

    
    

    for (int i = 0; i < 5; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame =  CGRectMake(buttonWidth * i, 0, buttonWidth, 30);
        [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + i;
        [self.tabBar addSubview:button];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(buttonWidth * i, CGRectGetMaxY(button.frame) + 4, buttonWidth, 15)];
        label.text = titleArray[i];
        label.font = [UIFont boldSystemFontOfSize:13];
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self.tabBar addSubview:label];
        
        
        
    }
    
    
}

- (void)buttonAction:(UIButton *)sender{
    
    self.selectedIndex = sender.tag - 100;
    
    
    
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
