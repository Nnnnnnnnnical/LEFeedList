//
//  LEQZone.h
//  FeedList
//
//  Created by leooooli on 2019/12/25.
//  Copyright © 2019 leooooli. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LEQZone : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSDate *time;
@property (nonatomic, copy) NSMutableArray *picture;

@property (nonatomic, assign) BOOL isOpen;

-(instancetype) initWithDict:(NSDictionary *)dict;
+(instancetype) qzoneWithDict:(NSDictionary *)dict;


@end

NS_ASSUME_NONNULL_END
