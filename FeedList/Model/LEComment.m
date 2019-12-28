//
//  LEComment.m
//  FeedList
//
//  Created by leooooli on 2019/12/26.
//  Copyright © 2019 leooooli. All rights reserved.
//

#import "LEComment.h"

@implementation LEComment

-(instancetype) initWithArray:(NSArray *)array
{
    self = [super init];
    if(self){
        self.commentArray = array;
    }
    return self;
}

+(instancetype) commentWithArray:(NSArray *)array;
{
    return [[self alloc]initWithArray:array];
}

@end
