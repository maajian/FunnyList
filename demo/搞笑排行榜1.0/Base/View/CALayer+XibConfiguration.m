//
//  CALayer+XibConfiguration.m
//  搞笑排行榜
//
//  Created by 叶英杰 on 9/13/16.
//  Copyright © 2016 叶英杰. All rights reserved.
//

#import "CALayer+XibConfiguration.h"
#import <UIKit/UIKit.h>

@implementation CALayer (XibConfiguration)

- (void)setBorderColorWithUIColor:(UIColor *)color
{
    self.borderColor = color.CGColor;
}

@end
