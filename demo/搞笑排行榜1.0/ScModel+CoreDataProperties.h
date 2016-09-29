//
//  ScModel+CoreDataProperties.h
//  搞笑排行榜1.0
//
//  Created by mac10 on 16/9/22.
//  Copyright © 2016年 CXCK. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ScModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ScModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *cate_id;
@property (nullable, nonatomic, retain) NSString *iD;
@property (nullable, nonatomic, retain) NSString *timeStr;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSNumber *isShoucan;

@end

NS_ASSUME_NONNULL_END
