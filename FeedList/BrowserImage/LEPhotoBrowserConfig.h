//
//  LEPhotoBrowserConfig.h
//  LEPhotoBrowser
//
//  Created by aier on 15-2-9.
//  Copyright (c) 2015年 GLE. All rights reserved.
//


typedef enum {
    LEWaitingViewModeLoopDiagram, // 环形
    LEWaitingViewModePieDiagram // 饼型
} LEWaitingViewMode;



// browser背景颜色
#define LEPhotoBrowserBackgrounColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.95]

// browser中图片间的margin
#define LEPhotoBrowserImageViewMargin 10

// browser中显示图片动画时长
#define LEPhotoBrowserShowImageAnimationDuration 0.4f

// browser中隐藏图片动画时长
#define LEPhotoBrowserHideImageAnimationDuration 0.4f

//// 图片下载进度指示进度显示样式（LEWaitingViewModeLoopDiagram 环形，LEWaitingViewModePieDiagram 饼型）
//#define LEWaitingViewProgressMode LEWaitingViewModeLoopDiagram
//
//// 图片下载进度指示器背景色
//#define LEWaitingViewBackgroundColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]
//
//// 图片下载进度指示器内部控件间的间距
//#define LEWaitingViewItemMargin 10


