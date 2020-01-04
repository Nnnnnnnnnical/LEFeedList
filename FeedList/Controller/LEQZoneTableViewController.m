//
//  LEQZoneTableViewController.m
//  FeedList
//
//  Created by leooooli on 2019/12/25.
//  Copyright © 2019 leooooli. All rights reserved.
//

#import "LEQZoneTableViewController.h"
#import "LEQZoneFrame.h"
#import "LEQZoneTableViewCell.h"
#import "LEPictureView.h"

@interface LEQZoneTableViewController ()

@property (nonatomic, strong) NSArray *QZoneFrame;

@end

@implementation LEQZoneTableViewController

static NSString *ID = @"zone";

#pragma mark-加载
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[LEQZoneTableViewCell class] forCellReuseIdentifier:ID];
}

#pragma mark -懒加载
-(NSArray *)QZoneFrame
{
    if(_QZoneFrame == nil){
        _QZoneFrame = [LEQZoneFrame zoneFrame];
    }
    return _QZoneFrame;
}


#pragma mark - 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.QZoneFrame.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LEQZoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if(cell == nil){
        cell = [[LEQZoneTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }else{
        //清除评论区之间相互叠加
        [[cell viewWithTag:100] removeFromSuperview];
        [cell removeFromSuperview];
        LEQZoneFrame *zoneFrame = self.QZoneFrame[indexPath.row];
        cell.zoneFrame = zoneFrame;
    }
    
    cell.indexPath = indexPath;
    if (!cell.moreButtonClickedBlock) {
        [cell setMoreButtonClickedBlock:^(NSIndexPath *indexPath) {
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
    }
    
    if (!cell.commentSendBlock) {
        [cell setCommentSendBlock:^(NSIndexPath *indexPath) {
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
    }
    
    return cell;
}

#pragma mark - 代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LEQZoneFrame *zoneFrame = self.QZoneFrame[indexPath.row];
    return zoneFrame.cellHeight;

}

#pragma mark -隐藏上面的状态栏
-(BOOL) prefersStatusBarHidden{
    return YES;
}

@end
