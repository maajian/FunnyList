//
//  PlayViewController.m
//  搞笑排行榜
//
//  Created by 叶英杰 on 9/14/16.
//  Copyright © 2016 叶英杰. All rights reserved.
//

#import "PlayViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>


@interface PlayViewController ()


@end

@implementation PlayViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playWithURL:) name:@"play" object:nil];
        
        
    }
    return self;
}


- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad{
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
    
}



- (void)playWithURL:(NSNotification *)notification{
    NSURL *url;
    
    NSString *str = [NSString stringWithFormat:@"%@",notification.userInfo[@"mp4_url"]];
    
    if ([str isEqualToString:@"web"]) {
        
        url = notification.userInfo[@"web_url"];
    }else{
        
        url = notification.userInfo[@"mp4_url"];
    }
    
    
    
    
    
    AVPlayer *player = [AVPlayer playerWithURL:url];
    
    AVPlayerViewController *playerVC = [[AVPlayerViewController alloc]init];
    playerVC.player = player;
    
    playerVC.view.frame = CGRectMake(0, 64, kScreenWidth, 200);
    [self presentViewController:playerVC animated:YES completion:nil];
    [playerVC.player play];
    
}






@end
