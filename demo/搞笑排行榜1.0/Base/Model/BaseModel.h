//
//  BaseModel.h
//  搞笑排行榜
//
//  Created by 叶英杰 on 9/13/16.
//  Copyright © 2016 叶英杰. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "YYModel.h"
//#import "NSObject+YYModel.h"
/*
 
 {
 cTime = 1473738642;
 "cate_id" = 6;
 downUrl = "";
 "favo_num" = 17;
 id = 220609;
 "mp4_url" = "";
 pic = "";
 "pic_h" = 15;
 "pic_t" = "";
 "pic_w" = 0;
 timeStr = "\U4eca\U5929 11:50";
 title = "\U6628\U665a\U6211\U7239\U5728\U5410\U69fd\U9ec4\U8d2f\U4e2d\U957f\U5f97\U4e0d\U592a\U597d\U770b\U5a36\U4e86\U4e2a\U8fd9\U4e48\U7f8e\U7684\U59b9\U7eb8'''' \U6211\U5988\U5988\U8bf4'' \U4f60\U957f\U6210\U8fd9\U6837\U4e0d\U4e5f\U627e\U4e86\U4e2a\U8fd9\U4e48\U6f02\U4eae\U7684\U8001\U5a46\U5417' \U6211\U7238\U6de1\U6de1\U5f97\U770b\U7740\U6211\U5988\U5988\U6765\U4e86\U53e5' \U4f60\U8981\U6e05\U695a\U4f60\U5f53\U65f6\U7684\U751f\U6d3b\U73af\U5883\Uff01\U6211\U5c31\U662f\U90a3\U7fa4\U765e\U86e4\U87c6\U4e2d\U7684\U4e00\U53ea\U9752\U86d9\Uff01";
 uid = 0;
 uname = "\U7b11\U8bdd\U767e\U79d1";
 "web_url" = "";
 "zan_num" = 364;
 },

 */
@interface BaseModel : NSObject


//@property (nonatomic, assign) NSInteger totalRow;
@property (nonatomic, copy) NSString *cate_id;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger favo_num;
@property (nonatomic, assign) NSInteger pic_h;
@property (nonatomic, assign) NSInteger pic_w;
@property (nonatomic, assign) NSInteger zan_num;
@property (nonatomic, copy) NSString *pic_t;
@property (nonatomic, copy) NSString *timeStr;
@property (nonatomic, copy) NSString *uname;
@property (nonatomic, copy) NSURL *downUrl;
@property (nonatomic, copy) NSURL *mp4_url;
@property (nonatomic, copy) NSURL *web_url;
@property (nonatomic, copy) NSURL *pic;
@property(nonatomic,assign)NSInteger cTime;







@end
