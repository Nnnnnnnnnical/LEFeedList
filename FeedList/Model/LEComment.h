//
//  LEComment.h
//  FeedList
//
//  Created by leooooli on 2019/12/26.
//  Copyright © 2019 leooooli. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LEComment : NSObject <NSCoding>

@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *secondName;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy) NSArray *commentArray;


-(instancetype) initWithArray:(NSArray *)array;
+(instancetype) commentWithArray:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
