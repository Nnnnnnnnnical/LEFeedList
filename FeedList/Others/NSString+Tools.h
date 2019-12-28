//
//  NSString+Tools.h
//
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>/


@interface NSString (Tools)

/**
 *  计算当前字符串显示所需的实际frame，返回值的x = 0, y = 0
 */
- (CGRect)textRectWithSize:(CGSize)size attributes:(NSDictionary *)attributes;


@end
