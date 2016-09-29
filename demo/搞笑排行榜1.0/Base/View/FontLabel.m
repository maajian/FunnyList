//
//  FontLabel.m
//  搞笑排行榜1.0
//
//  Created by mac10 on 16/9/20.
//  Copyright © 2016年 CXCK. All rights reserved.
//

#import "FontLabel.h"

@implementation FontLabel

- (instancetype)initWithFrame:(CGRect)frame
{
   NSString *fontStr1 = [[NSUserDefaults standardUserDefaults]objectForKey:kCurrentFont];
 
    NSInteger num1 = [fontStr1 integerValue];

    self = [super initWithFrame:frame];
    if (self) {
        if (num1==0) {
            self.font = [UIFont systemFontOfSize:15];
            
        }
        else if (num1==1)
        {
            self.font = [UIFont systemFontOfSize:16];
        }
        else if (num1==2)
        {
            self.font = [UIFont systemFontOfSize:17];
        }
        else if (num1==3)
        {
            self.font = [UIFont systemFontOfSize:18];
        }
        else{
            self.font = [UIFont systemFontOfSize:19];
            
        }
         [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeFont:) name:kFontChangeNoti object:nil];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeFont:) name:kFontChangeNoti object:nil];
    }
    return self;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)changeFont:(NSNotification *)fontString
{
    NSString *fontStr = fontString.userInfo[@"fontChange"];
    NSInteger fontNum = [fontStr integerValue];
    _num = fontNum;
    if (fontNum==0) {
        self.font = [UIFont systemFontOfSize:15];

    }
    else if (fontNum==1)
             {
                  self.font = [UIFont systemFontOfSize:16];
             }
    else if (fontNum==2)
    {
        self.font = [UIFont systemFontOfSize:17];
    }
    else if (fontNum==3)
    {
        self.font = [UIFont systemFontOfSize:18];
    }
    else{
        self.font = [UIFont systemFontOfSize:19];

    }
    
}

- (void)setFontString:(NSString *)fontString
{
    _fontString = [fontString copy];
    [self changeFont:(NSNotification *)fontString];
}









@end
