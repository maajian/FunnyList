//
//  TuijianCellLayout.h
//  搞笑排行榜1.0
//
//  Created by mac10 on 16/9/18.
//  Copyright © 2016年 CXCK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TuijianModel.h"
@interface TuijianCellLayout : NSObject
{
    CGFloat _cellHeight;
}
@property(nonatomic,strong)TuijianModel *model;
+ (instancetype)layoutWithTuijianModel:(TuijianModel *)model;
@property(nonatomic,assign,readonly)CGRect tuijianTextFrame;
- (CGFloat)cellHeight;
@end
