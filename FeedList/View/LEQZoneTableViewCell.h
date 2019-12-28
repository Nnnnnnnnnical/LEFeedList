//
//  LEQZoneTableViewCell.h
//  FeedList
//
//  Created by leooooli on 2019/12/25.
//  Copyright © 2019 leooooli. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LEQZoneFrame;

@interface LEQZoneTableViewCell : UITableViewCell

@property (nonatomic, strong) LEQZoneFrame * zoneFrame;
@property (nonatomic, assign) CGRect picF;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, copy) void (^moreButtonClickedBlock)(NSIndexPath *indexPath);
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

NS_ASSUME_NONNULL_END
