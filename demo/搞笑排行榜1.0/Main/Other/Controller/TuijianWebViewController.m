//
//  TuijianWebViewController.m
//  搞笑排行榜1.0
//
//  Created by mac10 on 16/9/19.
//  Copyright © 2016年 CXCK. All rights reserved.
//

#import "TuijianWebViewController.h"

@interface TuijianWebViewController ()

@end

@implementation TuijianWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *web = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:web];
    NSURLRequest *Request = [[NSURLRequest alloc]initWithURL:self.url];
    [web loadRequest:Request];
    
    // Do any additional setup after loading the view.
}

- (instancetype)initWithURL:(NSURL *)url
{
    self = [super init];
    if (self) {
        self.url = url;
    }
    return self;
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
