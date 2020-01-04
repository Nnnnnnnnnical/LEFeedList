//
//  LEQZoneFrame.h
//  FeedList
//
//  Created by leooooli on 2019/12/25.
//  Copyright © 2019 leooooli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LEQZone.h"
#import "LEPictureView.h"
#import "LEComment.h"
#import "LECommentView.h"
NS_ASSUME_NONNULL_BEGIN


@interface LEQZoneFrame : NSObject

@property (nonatomic, assign, readonly) CGRect iconF;
@property (nonatomic, assign, readonly) CGRect nameF;
@property (nonatomic, assign, readonly) CGRect textF;
@property (nonatomic, assign, readonly) CGRect moreTextF;
@property (nonatomic, assign, readonly) CGRect timeF;
@property (nonatomic, assign, readonly) CGRect pictureF;
@property (nonatomic, assign, readonly) CGRect likeF;
@property (nonatomic, assign, readonly) CGRect commentF;
@property (nonatomic, assign, readonly) CGRect repostF;
@property (nonatomic, assign, readonly) CGRect commentTextF;
@property (nonatomic, assign, readonly) CGRect commentButtonF;
@property (nonatomic, assign, readonly) CGRect commentsF;


/** 行高 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;


/** 所有控件的尺寸都可以通过zone来计算得出 */
@property (nonatomic, strong) LEQZone *zone;

@property (nonatomic, strong) NSMutableArray *commentArray;

@property (nonatomic, strong) LECommentView *commentView;


#pragma mark - 所有的zoneFrame数据数组
+ (NSArray *)zoneFrame;

@end

NS_ASSUME_NONNULL_END
