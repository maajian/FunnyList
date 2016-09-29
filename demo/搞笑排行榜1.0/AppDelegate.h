//
//  AppDelegate.h
//  搞笑排行榜1.0
//
//  Created by Mac on 16/8/14.
//  Copyright © 2016年 CXCK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,SinaWeiboDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)SinaWeibo *_weibo;
-(void)logoutWeibo;
-(BOOL)loginWeibo;
@end

