//
//  LEPictureTableViewCell.m
//  FeedList
//
//  Created by leooooli on 2019/12/26.
//  Copyright © 2019 leooooli. All rights reserved.
//

#import "LEPictureTableViewCell.h"

@interface LEPictureTableViewCell()

@property (nonatomic, strong)NSArray *pictureArray;

@end

@implementation LEPictureTableViewCell

#pragma mark -初始化frame
-(instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

#pragma mark -s初始化setup方法
-(void)setup
{
    NSMutableArray *temp = [NSMutableArray new];
    
    for (int i = 0; i < 9; i++) {
        UIImageView *imageView = [UIImageView new];
        [self addSubview:imageView];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [imageView addGestureRecognizer:tap];
        [temp addObject:imageView];
    }
    
    self.pictureArray = [temp copy];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
