//
//  LECommentView.h
//  FeedList
//
//  Created by leooooli on 2019/12/26.
//  Copyright © 2019 leooooli. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LECommentView : UIView

@property (nonatomic, strong) NSMutableArray *commentArray;
@property (nonatomic, assign, readonly) CGRect commentF;

-(instancetype)initWithCommentArray:(NSMutableArray *)commentArray;

@end

NS_ASSUME_NONNULL_END
