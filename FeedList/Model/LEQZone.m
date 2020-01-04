//
//  LEQZone.m
//  FeedList
//
//  Created by leooooli on 2019/12/25.
//  Copyright © 2019 leooooli. All rights reserved.
//

#import "LEQZone.h"


@implementation LEQZone

-(instancetype) initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if(self){
        self.id = [dict[@"id"] integerValue];
        self.icon = dict[@"icon"];
        self.name = dict[@"name"];
        self.text = dict[@"text"];
        self.picture = dict[@"picture"];
        self.time = dict[@"time"];
        self.isOpen = NO;
//        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
    
}
+(instancetype) qzoneWithDict:(NSDictionary *)dict
{
    
    return [[self alloc]initWithDict: dict];
}

@end
