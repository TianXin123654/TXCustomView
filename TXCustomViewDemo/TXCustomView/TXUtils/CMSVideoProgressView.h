//
//  CMSVideoProgressView.h
//  cms
//
//  Created by 新华龙mac on 2017/10/19.
//  Copyright © 2017年 新华龙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ProgressType){
    progressType_circle,//圆圈
    progressType_striping //横线
};

@interface CMSVideoProgressView : UIView

@property (assign, nonatomic) ProgressType progressType;//进度条类型
@property (nonatomic, assign) CGFloat progressValue;// 范围: 0 ~ 1

+ (instancetype)viewWithFrame:(CGRect)frame circlesSize:(CGRect)size;

@end
