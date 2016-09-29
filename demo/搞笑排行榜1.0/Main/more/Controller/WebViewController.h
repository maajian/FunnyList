//
//  WebViewController.h
//  搞笑排行榜1.0
//
//  Created by mac10 on 16/9/18.
//  Copyright © 2016年 CXCK. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController
@property(nonatomic,strong)NSURL *url;
- (instancetype)initWithURL:(NSURL *)url;
@end
