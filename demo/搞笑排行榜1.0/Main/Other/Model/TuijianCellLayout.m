//
//  TuijianCellLayout.m
//  搞笑排行榜1.0
//
//  Created by mac10 on 16/9/18.
//  Copyright © 2016年 CXCK. All rights reserved.
//

#import "TuijianCellLayout.h"
#import "WXLabel.h"
@implementation TuijianCellLayout
+(instancetype)layoutWithTuijianModel:(TuijianModel *)model
{
    TuijianCellLayout *layout = [[TuijianCellLayout alloc]init];
    if (layout) {
        layout.model = model;
    }
    return layout;

}
 - (void)setModel:(TuijianModel *)model
{
    if (_model==model) {
        return  ;
    }
    
    _model = model;
    _cellHeight = 0;
   CGFloat textHeight = [WXLabel getTextHeight:[UIFont systemFontOfSize:14].pointSize width:180 text:_model.app_intro linespace:3];
    _cellHeight=52+ textHeight;
    
    
    
    
}


- (CGFloat)cellHeight
{
    return _cellHeight;
}

@end
