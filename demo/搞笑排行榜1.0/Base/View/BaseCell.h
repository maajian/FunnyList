//
//  BaseCell.h
//  搞笑排行榜
//
//  Created by 叶英杰 on 9/13/16.
//  Copyright © 2016 叶英杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"
#import "FontLabel.h"
@interface BaseCell : UITableViewCell
@property (nonatomic, strong) BaseModel *model;
@property (strong, nonatomic) FontLabel *baseTextLabel;
@property (strong, nonatomic) UIImageView *imgView;
@end
