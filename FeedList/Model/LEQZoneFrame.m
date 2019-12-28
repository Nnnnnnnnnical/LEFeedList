//
//  LEQZoneFrame.m
//  FeedList
//
//  Created by leooooli on 2019/12/25.
//  Copyright © 2019 leooooli. All rights reserved.
//

#import "LEQZoneFrame.h"
#import "LEQZone.h"
#import "NSString+Tools.h"
#import "LEPictureView.h"


/** 时间字体*/
#define kTimeFont   [UIFont systemFontOfSize:13]
/** 姓名字体 */
#define kNameFont   [UIFont systemFontOfSize:15]
/** 正文字体 */
#define kTextFont   [UIFont systemFontOfSize:16]
/** 评论点赞图标大小*/
#define commentLikeImage 30
@implementation LEQZoneFrame

#pragma mark -重写set方法
- (void)setZone:(LEQZone *)zone
{
    _zone = zone;
    
    // 定义间距
    CGFloat padding = 10;
    
    //  头像
    CGFloat iconX = padding;
    CGFloat iconY = padding;
    CGFloat iconW = 40;
    CGFloat iconH = 40;
    _iconF = CGRectMake(iconX, iconY, iconW, iconH);
    
    //昵称
    NSDictionary *nameDict = @{NSFontAttributeName: kNameFont};
    CGRect nameFrame = [self.zone.name textRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) attributes:nameDict];
    nameFrame.origin.x = CGRectGetMaxX(self.iconF) + padding;
    nameFrame.origin.y = _iconF.origin.y;
    _nameF = nameFrame;
    
    //时间
    NSDictionary *timeDict = @{NSFontAttributeName: kTimeFont};
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:zone.time];
    CGRect timeFrame = [strDate textRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) attributes:timeDict];
    
    timeFrame.origin.x = nameFrame.origin.x;
    timeFrame.origin.y = CGRectGetMaxY(timeFrame) + padding + 5;
    _timeF = timeFrame;
    
    // 正文
    NSDictionary *textDict = @{NSFontAttributeName: kTextFont};
    CGFloat maxW = [[UIScreen mainScreen]bounds].size.width-padding-5;
    CGRect temp = [@"abc" textRectWithSize:CGSizeMake(1, MAXFLOAT) attributes:textDict];
    CGRect textFrame = CGRectMake(0, 0, 0, 0);
    if(zone.isOpen == NO) {
        textFrame = [self.zone.text textRectWithSize:CGSizeMake(maxW, temp.size.height) attributes:textDict];
    }else{
        textFrame = [self.zone.text textRectWithSize:CGSizeMake(maxW, MAXFLOAT) attributes:textDict];
    }
    
    textFrame.origin.x = padding;
    textFrame.origin.y = CGRectGetMaxY(self.iconF) + padding;
    _textF = textFrame;
    
    //显示正文
    CGFloat moreTextX = padding;
    CGFloat moreTextY = CGRectGetMaxY(_textF);
    CGFloat moreTextW = 50;
    CGFloat moreTextH = 30;
    _moreTextF = CGRectMake(moreTextX, moreTextY, moreTextW, moreTextH);
    
    //转发
    CGFloat repostY = 0;
    CGFloat repostW = commentLikeImage;
    CGFloat repostH = commentLikeImage;
    CGFloat repostX = maxW - padding - repostW;
    
    if (self.zone.picture.count > 0) {
        
        LEPictureView *pictureView = [LEPictureView new];
        pictureView.picPathStringsArray = zone.picture;
        // 配图
        CGFloat pictureX = padding;
        CGFloat pictureY = CGRectGetMaxY(_moreTextF) + padding;
        CGFloat pictureW = maxW;
        CGFloat pictureH = CGRectGetMaxY(pictureView.picF);
        _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
       
        repostY = CGRectGetMaxY(_pictureF) + padding;
    
    } else {
        repostY= CGRectGetMaxY(_moreTextF) + padding;
        
    }
    _repostF = CGRectMake(repostX, repostY, repostW, repostH);
   

    //评论
    CGFloat commentY = repostY;
    CGFloat commentW = commentLikeImage;
    CGFloat commentH = commentLikeImage;
    CGFloat commentX = repostX - padding - 5 - commentW;
    _commentF = CGRectMake(commentX, commentY, commentW, commentH);
    

    
    //点赞
    CGFloat likeW = commentLikeImage;
    CGFloat likeH = commentLikeImage;
    CGFloat likeX = commentX-padding-5-likeW;
    CGFloat likeY = repostY;
    _likeF = CGRectMake(likeX, likeY, likeW, likeH);
    
    //评论区
    CGFloat commentsX = padding;
    CGFloat commentsY = CGRectGetMaxY(_likeF) + padding;
    CGFloat commentsW = maxW;
    CGFloat commentsH = 20 * (_commentView.commentArray.count);
    _commentsF = CGRectMake(commentsX,commentsY,commentsW,commentsH);
    
    //评论框
    CGFloat commentTextX = padding;
    CGFloat commentTextY = CGRectGetMaxY(_commentsF)+padding;
    CGFloat commentTextW = maxW;
    CGFloat commentTextH = 30;
    _commentTextF = CGRectMake(commentTextX, commentTextY, commentTextW, commentTextH);
    
    
    
    _cellHeight = CGRectGetMaxY(_commentTextF) + padding;
    
}

#pragma mark -init初始化
+(NSArray *)zoneFrame
{
    //获取头像，昵称，时间，文本和图片信息
    NSString *path = [[NSBundle mainBundle] pathForResource:@"zoom.plist" ofType:nil];
    NSArray *array = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *arrayModel = [NSMutableArray array];
    
    //获取评论信息
    NSString *commentPath = [[NSBundle mainBundle] pathForResource:@"comment.plist" ofType:nil];
    NSArray *allCommentArray = [NSArray arrayWithContentsOfFile:commentPath];
    for(int i = 0;i < array.count;i++){
        NSDictionary *dict = array[i];
        NSArray *commentArray = allCommentArray[i];
        LEQZone *zone = [LEQZone qzoneWithDict:dict];
        LEQZoneFrame *zoneFrame = [[LEQZoneFrame alloc] init];
        LEComment *comment = [LEComment commentWithArray:commentArray];
        LECommentView *commentView = [[LECommentView alloc]initWithCommentArray:comment.commentArray];
        zoneFrame.commentView = commentView;
        zoneFrame.zone = zone;
        zoneFrame.commentArray = comment.commentArray;
        

        [arrayModel addObject:zoneFrame];
    }
    return arrayModel;
}

@end
