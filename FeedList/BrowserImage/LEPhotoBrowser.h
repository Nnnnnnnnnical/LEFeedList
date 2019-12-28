//
//  LEPhotoBrowser.h
//  photobrowser
//
//  Created by aier on 15-2-3.
//  Copyright (c) 2015年 aier. All rights reserved.
//

#import <UIKit/UIKit.h>


@class LEButton, LEPhotoBrowser;

@protocol LEPhotoBrowserDelegate <NSObject>

@required

- (UIImage *)photoBrowser:(LEPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index;

@optional

- (NSURL *)photoBrowser:(LEPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index;

@end


@interface LEPhotoBrowser : UIView <UIScrollViewDelegate>

@property (nonatomic, weak) UIView *sourceImagesContainerView;
@property (nonatomic, assign) NSInteger currentImageIndex;
@property (nonatomic, assign) NSInteger imageCount;

@property (nonatomic, weak) id<LEPhotoBrowserDelegate> delegate;

- (void)show;

@end
