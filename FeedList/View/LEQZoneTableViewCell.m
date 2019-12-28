//
//  LEQZoneTableViewCell.m
//  FeedList
//
//  Created by leooooli on 2019/12/25.
//  Copyright © 2019 leooooli. All rights reserved.
//

#import "LEQZoneTableViewCell.h"
#import "LEQZone.h"
#import "LEQZoneFrame.h"
#import "LEPictureView.h"
#import "LECommentView.h"
#import "LEComment.h"

@interface LEQZoneTableViewCell()

@property (nonatomic, strong)UIImageView *iconView;
@property (nonatomic, strong)UILabel *nameView;
@property (nonatomic, strong)UILabel *textView;
@property (nonatomic, strong)UILabel *timeView;
@property (nonatomic, strong)LEPictureView *pictureView;
@property (nonatomic, strong)UIImageView *likeView;
@property (nonatomic, strong)UIImageView *commentImageView;
@property (nonatomic, strong)UIImageView *repostView;
@property (nonatomic, strong)UITextView *commentTextView;
@property (nonatomic, strong)LECommentView  *commentsView;

@property (nonatomic, assign)CGRect commentF;
@end


@implementation LEQZoneTableViewCell

/** 时间字体*/
#define kTimeFont   [UIFont systemFontOfSize:13]
/** 姓名字体 */
#define kNameFont   [UIFont systemFontOfSize:15]
/** 正文字体 */
#define kTextFont   [UIFont systemFontOfSize:16]

{
    LEPictureView *_pictureContainer;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self setupView];
    }
    return self;
}

-(void)setupView
{
    
    _iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:_iconView];
    
    _nameView = [[UILabel alloc]init];
    _nameView.font = kNameFont;
    [self.contentView addSubview:_nameView];
    
    _textView = [[UILabel alloc]init];
    _textView.font = kTextFont;
    _textView.numberOfLines = 0;
    [self.contentView addSubview:_textView];
    
    _timeView = [[UILabel alloc]init];
    _timeView.font = kTimeFont;
    _timeView.textColor = [UIColor grayColor];
    [self.contentView addSubview:_timeView];
    
    _pictureView = [LEPictureView new];
    [self.contentView addSubview:_pictureView];
    
    _likeView = [[UIImageView alloc]init];
    [self.contentView addSubview:_likeView];
    
    _repostView = [[UIImageView alloc]init];
    [self.contentView addSubview:_repostView];
    
    _commentImageView = [[UIImageView alloc]init];
    [self.contentView addSubview:_commentImageView];
    
    _commentTextView = [[UITextView alloc]init];
    [_commentTextView setBackgroundColor:[UIColor colorWithRed:(243)/255.0 green:(242)/255.0 blue:(249)/255.0 alpha:1.0]];
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"评论";
    placeHolderLabel.numberOfLines = 0;
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    _commentTextView.font = [UIFont systemFontOfSize:13.f];
    placeHolderLabel.font = [UIFont systemFontOfSize:13.f];
    [_commentTextView addSubview:placeHolderLabel];
    [_commentTextView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    [self.contentView addSubview:_commentTextView];
    
    

}


#pragma mark -
-(void)setZoneFrame:(LEQZoneFrame *)zoneFrame
{
    _zoneFrame = zoneFrame;
    _commentsView = [[LECommentView alloc]initWithCommentArray:zoneFrame.commentView.commentArray];
    [self.contentView addSubview:_commentsView];
    [self settingData];
    
    [self settingFrame];
}


#pragma mark -设置数据
- (void)settingData
{
    LEQZone *zone = self.zoneFrame.zone;
    NSMutableArray *commentArray = self.zoneFrame.commentView.commentArray;
    LECommentView *commentView = [[LECommentView alloc]initWithCommentArray:commentArray];
    self.commentF = commentView.commentF;
    _pictureContainer = self.pictureView;
    
    //头像
    self.iconView.image = [UIImage imageNamed:zone.icon];
    
    //姓名
    self.nameView.text = zone.name;
    
    //时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:zone.time];
    self.timeView.text = strDate;
    
    //正文
    self.textView.text = zone.text;
    
    //评论
    self.commentImageView.image = [UIImage imageNamed:@"toolbar_icon_comment"];
    
    //点赞
    self.likeView.image = [UIImage imageNamed:@"toolbar_icon_praise"];
    
    //转发
    self.repostView.image = [UIImage imageNamed:@"toolbar_icon_re"];
    
    //配图
    self.pictureView.picPathStringsArray = zone.picture;
    
    //评论区
    self.commentsView.commentArray = commentView.commentArray;
    
}

#pragma mark -设置位置
- (void)settingFrame
{
    // 1. 头像
    self.iconView.frame = self.zoneFrame.iconF;
    
    // 2. 姓名大小由文字的长度来决定
    self.nameView.frame = self.zoneFrame.nameF;
    
    //时间
    self.timeView.frame = self.zoneFrame.timeF;
    
    // 正文
    self.textView.frame = self.zoneFrame.textF;
    
//    // 配图
//    if (self.zoneFrame.zone.picture.count > 0) {
//        self.pictureView.frame = self.zoneFrame.pictureF;
//    }
    self.pictureView.frame = self.zoneFrame.pictureF;
    
    //评论
    self.commentImageView.frame = self.zoneFrame.commentF;
    
    //喜欢
    self.likeView.frame = self.zoneFrame.likeF;
    
    //转发
    self.repostView.frame = self.zoneFrame.repostF;
    
    //评论区
    self.commentTextView.frame = self.zoneFrame.commentTextF;
    
    self.commentsView.frame = self.zoneFrame.commentsF;

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
