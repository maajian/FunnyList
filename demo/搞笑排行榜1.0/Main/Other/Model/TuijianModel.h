//
//  TuijianModel.h
//  搞笑排行榜1.0
//
//  Created by mac10 on 16/9/18.
//  Copyright © 2016年 CXCK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TuijianModel : NSObject
@property(nonatomic,assign)NSNumber  *AppId;
@property(nonatomic,strong)NSString *name;   //名字app
@property(nonatomic,strong)NSString *app_intro;//text  app内容
@property(nonatomic,strong)NSURL *appIconURL;
@property(nonatomic,strong)NSURL *clickURL;
@end
