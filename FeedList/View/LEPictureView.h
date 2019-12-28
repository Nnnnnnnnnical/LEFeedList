//
//  LEPictureView.h
//  FeedList
//
//  Created by leooooli on 2019/12/26.
//  Copyright © 2019 leooooli. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LEPictureView : UIView
@property (nonatomic, strong) NSMutableArray *picPathStringsArray;
@property (nonatomic, assign, readonly) CGRect picF;

@end

NS_ASSUME_NONNULL_END
