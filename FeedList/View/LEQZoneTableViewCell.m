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
#import "NSString+Tools.h"

@interface LEQZoneTableViewCell()

@property (nonatomic, strong)UIImageView *iconView;
@property (nonatomic, strong)UILabel *nameView;
@property (nonatomic, strong)UILabel *textView;
@property (nonatomic, strong)UIButton *moreButton;
@property (nonatomic, strong)UILabel *timeView;
@property (nonatomic, strong)LEPictureView *pictureView;
@property (nonatomic, strong)UIImageView *likeView;
@property (nonatomic, strong)UIImageView *commentImageView;
@property (nonatomic, strong)UIImageView *repostView;
@property (nonatomic, strong)UITextView *commentTextView;
@property (nonatomic, strong)UIButton *commentButtonView;
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
    CGFloat maxTextHeight;
    Boolean isOpen;
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
    NSDictionary *textDict = @{NSFontAttributeName: kTextFont};
    CGRect temp = [@"abc" textRectWithSize:CGSizeMake(1, MAXFLOAT) attributes:textDict];
    maxTextHeight = temp.size.height;
    [self.contentView addSubview:_textView];
    
    _moreButton = [[UIButton alloc]init];
    _moreButton.titleLabel.font  = kNameFont;
    [_moreButton setTitleColor:[UIColor colorWithRed:92/255.0 green:140/255.0 blue:193/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_moreButton];

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
    
    //评论发送按钮
    _commentButtonView = [[UIButton alloc]init];
    [_commentButtonView setTitle:@"发送" forState:UIControlStateNormal];
    [_commentButtonView setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    _commentButtonView.layer.cornerRadius = 5.0;
    _commentButtonView.backgroundColor = [UIColor colorWithRed:(0)/255.0 green:(122)/255.0 blue:(255)/255.0 alpha:1.0];
    [_commentButtonView addTarget:self action:@selector(sendComment) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_commentButtonView];
    
    
    _commentTextView = [[UITextView alloc]init];
    [_commentTextView setBackgroundColor:[UIColor colorWithRed:(243)/255.0 green:(242)/255.0 blue:(249)/255.0 alpha:1.0]];
    UILabel *placeHolderLabel = [[UILabel alloc] init];
    placeHolderLabel.text = @"评论";
    placeHolderLabel.textColor = [UIColor lightGrayColor];
    [placeHolderLabel sizeToFit];
    _commentTextView.font = [UIFont systemFontOfSize:13.f];
    placeHolderLabel.font = [UIFont systemFontOfSize:13.f];
    [_commentTextView addSubview:placeHolderLabel];
    [_commentTextView setValue:placeHolderLabel forKey:@"_placeholderLabel"];
    
    _commentTextView.returnKeyType = UIReturnKeySend;
    _commentTextView.delegate = self;
    [self.contentView addSubview:_commentTextView];
    
    
    
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//    [center addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    

}

#pragma mark -移除
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
    
    //是否显示正文
    NSDictionary *textDict = @{NSFontAttributeName: kTextFont};
    CGFloat maxW = [[UIScreen mainScreen]bounds].size.width-10-5;
    CGRect textFrame = [self.zoneFrame.zone.text textRectWithSize:CGSizeMake(maxW, MAXFLOAT) attributes:textDict];
    if (textFrame.size.height > maxTextHeight) {
        self.moreButton.hidden = NO;
        if(zone.isOpen){
            _textView.numberOfLines = 0;
            [self.moreButton setTitle:@"收起" forState:UIControlStateNormal];
        }else{
            _textView.numberOfLines = 3;
            [self.moreButton setTitle:@"全文" forState:UIControlStateNormal];
        }
        
    }else{
        self.moreButton.hidden = YES;
    }
    
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
    
    //是否显示正文
    self.moreButton.frame = self.zoneFrame.moreTextF;
    
    //配图
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
    
    //评论发送按钮
    self.commentButtonView.frame = self.zoneFrame.commentButtonF;

}

#pragma mark -全文和收起按钮
-(void)moreButtonClicked{
    LEQZone *zone = self.zoneFrame.zone;
    zone.isOpen = !self.zoneFrame.zone.isOpen;
    _zoneFrame.zone = zone;
    if (self.moreButtonClickedBlock) {
        self.moreButtonClickedBlock(self.indexPath);
    }
    
}

#pragma mark -发送评论内容
-(void)sendComment
{
    NSString *text = _commentTextView.text;
    if (text.length == 0) {
        NSLog(@"1111");
        
    }else{

        // 1.获得沙盒根路径
        NSString *home = NSHomeDirectory();
        // 2.document路径
        NSString *docPath = [home stringByAppendingPathComponent:@"Documents"];
        // 3.文件路径
        NSString *filepath = [docPath stringByAppendingPathComponent:@"comment.plist"];
        //创建数据字典
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setValue:@"leooooli" forKey:@"firstName"];
        [dic setValue:_zoneFrame.zone.name forKey:@"secondName"];
        [dic setValue:text forKey:@"comment"];

        NSMutableArray *res = [NSMutableArray arrayWithContentsOfFile:filepath];
        [res[_zoneFrame.zone.id-1] addObject:dic];
        
        //将数据写入到文件中
        [res writeToFile:filepath atomically:YES];
        
        LEComment *comment = [LEComment commentWithArray:res[_zoneFrame.zone.id-1]];
        LECommentView *commentView = [[LECommentView alloc]initWithCommentArray:comment.commentArray];
        _zoneFrame.commentView = commentView;
        _zoneFrame.commentArray = comment.commentArray;
        _zoneFrame.zone = _zoneFrame.zone;
        _commentTextView.text = @"";
        
        if (self.commentSendBlock) {
            self.commentSendBlock(self.indexPath);
        }
    }
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [_commentTextView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_commentTextView isExclusiveTouch]) {
        [_commentTextView resignFirstResponder];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self sendComment];
    NSLog(@"11");
    return YES;
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
