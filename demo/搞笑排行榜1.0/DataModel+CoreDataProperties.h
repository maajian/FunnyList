//
//  DataModel+CoreDataProperties.h
//  搞笑排行榜
//
//  Created by 叶英杰 on 9/21/16.
//  Copyright © 2016 叶英杰. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "DataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DataModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *iD;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *cate_id;

@end

NS_ASSUME_NONNULL_END
