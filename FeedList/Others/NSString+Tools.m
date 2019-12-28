//
//  NSString+Tools.m
//  
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "NSString+Tools.h"

@implementation NSString (Tools)

#pragma mark -self 就是调用当前成员方法的NSString对象
- (CGRect)textRectWithSize:(CGSize)size attributes:(NSDictionary *)attributes
{
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
}

@end
