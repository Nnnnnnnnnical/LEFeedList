//
//  LEBrowserImageView.h
//  LEPhotoBrowser
//
//  Created by aier on 15-2-6.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEWaitingView.h"


@interface LEBrowserImageView : UIImageView <UIGestureRecognizerDelegate>

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, assign, readonly) BOOL isScaled;
@property (nonatomic, assign) BOOL hasLoadedImage;

- (void)eliminateScale; // 清除缩放

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

- (void)doubleTapToZommWithScale:(CGFloat)scale;

- (void)clear;

@end
