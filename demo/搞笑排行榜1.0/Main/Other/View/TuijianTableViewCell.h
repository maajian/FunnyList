//
//  TuijianTableViewCell.h
//  搞笑排行榜1.0
//
//  Created by mac10 on 16/9/18.
//  Copyright © 2016年 CXCK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXLabel.h"
#import "TuijianModel.h"
@interface TuijianTableViewCell : UITableViewCell
@property(nonatomic,strong)TuijianModel  *model;
@property (weak, nonatomic) IBOutlet UIImageView *appImageView;
@property (weak, nonatomic) IBOutlet UILabel *appName;
@property (weak, nonatomic) IBOutlet UIButton *downLoad;
@property(nonatomic,strong)WXLabel *textLabel1;
@end
