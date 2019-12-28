//
//  LECommentView.m
//  FeedList
//
//  Created by leooooli on 2019/12/26.
//  Copyright © 2019 leooooli. All rights reserved.
//

#import "LECommentView.h"
#import "NSString+Tools.h"
@interface LECommentView ()

@end

@implementation LECommentView
/** 正文字体 */
#define kTextFont   [UIFont systemFontOfSize:16]
-(instancetype)initWithCommentArray:(NSMutableArray *)commentArray
{
    _commentArray = commentArray;
    self.tag = 100;
    self = [super init];
    if(self){
        for(int i = 0;i<commentArray.count;i++){
            CGFloat padding = 10;

            CGRect commentRect = CGRectMake(0, 0, 0, 0);
            for(int i = 0;i<_commentArray.count;i++){

                NSDictionary *dict = _commentArray[i];

                UIButton *firstNameButton = [[UIButton alloc]init];
                [firstNameButton setTitle:dict[@"firstName"] forState:UIControlStateNormal];
                firstNameButton.frame = CGRectMake(0,i * (padding+10), 70, 20);
                [firstNameButton setTitleColor:[UIColor colorWithRed:(104)/255.0 green:(116)/255.0 blue:(214)/255.0 alpha:1.0] forState:UIControlStateNormal];
                [firstNameButton setFont:kTextFont];
                firstNameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
         //        [firstNameButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
                [self addSubview:firstNameButton];

                //如果是第一次评论，不显示回复对象
                UILabel *commentLabel = [[UILabel alloc]init];

                if (dict[@"secondName"] == nil) {
                    [firstNameButton setTitle:[dict[@"firstName"] stringByAppendingString:@":"] forState:UIControlStateNormal];

                    commentLabel.frame = CGRectMake(firstNameButton.frame.origin.x + firstNameButton.frame.size.width + padding, firstNameButton.frame.origin.y , 200, firstNameButton.frame.size.height);
                    commentRect = commentLabel.frame;
                    _commentF = commentRect;
                    
                }else{
                    UILabel *response = [[UILabel alloc]init];
                    response.text = @"回复";
                    response.frame = CGRectMake(firstNameButton.frame.origin.x + firstNameButton.frame.size.width + padding, firstNameButton.frame.origin.y , 50, firstNameButton.frame.size.height);
                    response.textColor = [UIColor colorWithRed:(149)/255.0 green:(149)/255.0 blue:(149)/255.0 alpha:1.0];
                    [self addSubview:response];

                    UIButton *secondNameButton = [[UIButton alloc]init];
                    [secondNameButton setTitle:dict[@"secondName"] forState:UIControlStateNormal];
                    secondNameButton.frame = CGRectMake(response.frame.origin.x +response.frame.size.width + padding, firstNameButton.frame.origin.y, 70, 20);
                    secondNameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                    [secondNameButton setTitleColor:[UIColor colorWithRed:(104)/255.0 green:(116)/255.0 blue:(214)/255.0 alpha:1.0] forState:UIControlStateNormal];
                    [secondNameButton setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];

                    [self addSubview:secondNameButton];

                    
                    commentLabel.frame = CGRectMake(secondNameButton.frame.origin.x + secondNameButton.frame.size.width + padding, secondNameButton.frame.origin.y , 200, secondNameButton.frame.size.height);

                    commentRect = commentLabel.frame;
                    _commentF = commentRect;
                }
                commentLabel.text = dict[@"comment"];
                [commentLabel setTextColor:[UIColor colorWithRed:(25)/255.0 green:(25)/255.0 blue:(25)/255.0 alpha:1.0]];
                [commentLabel setFont:kTextFont];
                [self addSubview:commentLabel];
            }
        }
        
    }
    return self;
}


@end
