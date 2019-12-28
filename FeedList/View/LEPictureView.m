//
//  LEPictureView.m
//  FeedList
//
//  Created by leooooli on 2019/12/26.
//  Copyright © 2019 leooooli. All rights reserved.
//

#import "LEPictureView.h"
#import "LEQZone.h"
#import "SceneDelegate.h"
#import "LEPhotoBrowser.h"

@interface LEPictureView () <LEPhotoBrowserDelegate>

@property (nonatomic, strong) NSArray *imageViewsArray;
@property (nonatomic, strong) UIImageView *imageView;


/**阴影按钮*/
@property (nonatomic, weak) UIButton *cover;
/**记录头像原始尺寸*/
@property (nonatomic, assign)CGRect oldIconBtnFrame;
@end

@implementation LEPictureView

#define ScreenWidth [[UIScreen mainScreen]bounds].size.width
#define ScreenHeight [[UIScreen mainScreen]bounds].size.height

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [UIImageView new];
        [self addSubview:imageView];
        imageView.tag = i;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    
    self.imageViewsArray = [temp copy];
}

- (void)setPicPathStringsArray:(NSMutableArray *)picPathStringsArray
{
    _picPathStringsArray = picPathStringsArray;
    
    for (long i = _picPathStringsArray.count; i < self.imageViewsArray.count; i++) {
        UIImageView *imageView = [self.imageViewsArray objectAtIndex:i];
        imageView.hidden = YES;
    }

    CGFloat itemW = [self itemWidthForPicPathArray:_picPathStringsArray];
    CGFloat itemH = itemW;
    long perRowItemCount = [self perRowItemCountForPicPathArray:_picPathStringsArray];
    CGFloat margin = 5;
    
    [_picPathStringsArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        long columnIndex = idx % perRowItemCount;
        long rowIndex = idx / perRowItemCount;
        UIImageView *imageView = [_imageViewsArray objectAtIndex:idx];
        imageView.hidden = NO;
        imageView.image = [UIImage imageNamed:obj];
        
        CGFloat picX = columnIndex * (itemW + margin);
        CGFloat picY = rowIndex * (itemH + margin);

        _picF = CGRectMake(picX, picY, itemW, itemH);
        imageView.frame = _picF;
        imageView.backgroundColor = [UIColor redColor];
    }];
    
}

- (CGFloat)itemWidthForPicPathArray:(NSArray *)array
{
    if(array.count < 3){
        return ([[UIScreen mainScreen]bounds].size.width-20)/array.count;
    }
    if (array.count <= 4) {
        return ([[UIScreen mainScreen]bounds].size.width-25)/2;
    } else {
        return ([[UIScreen mainScreen]bounds].size.width-30)/3;
    }
}

- (NSInteger)perRowItemCountForPicPathArray:(NSArray *)array
{
    if (array.count < 3) {
        return array.count;
    } else if (array.count <= 4) {
        return 2;
    } else {
        return 3;
    }
}



#pragma mark - private actions
- (void)tapImageView:(UITapGestureRecognizer *)tap
{
    UIView *imageView = tap.view;

    LEPhotoBrowser *browser = [[LEPhotoBrowser alloc] init];
    browser.currentImageIndex = imageView.tag;
    browser.sourceImagesContainerView = self;
    browser.imageCount = self.picPathStringsArray.count;
    browser.delegate = self;
    [browser show];


}
//#pragma mark - LEPhotoBrowserDelegate
//- (NSURL *)photoBrowser:(LEPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
//{
//    NSString *imageName = self.picPathStringsArray[index];
//    NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
//    return url;
//}

- (UIImage *)photoBrowser:(LEPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.subviews[index];
    return imageView.image;
}@end
