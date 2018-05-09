//
//  TXCustomAnimationSetting.h
//  Lottery
//
//  Created by 新华龙mac on 2018/1/3.
//  Copyright © 2018年 新华龙mac. All rights reserved.
//  这个类 暂时没有做， 以后在扩展

#import <Foundation/Foundation.h>

@interface TXCustomAnimationSetting : NSObject

/**
 自定义图片是否圆角
 */
@property (nonatomic, assign)NSInteger cornerRadius;

/**
 是否取消上滑动画
 */
@property (nonatomic, assign)BOOL isCancelUpGes;

/**
 是否取消保存按钮
 */
@property (nonatomic, assign)BOOL isCanceSaveButton;

/**
 只有一张图片的时候是否按照比列缩小(这个优先级最高)
 */
@property (nonatomic, assign)BOOL isFitOneImage;

/**
 图片是否不不压缩
 */
@property (nonatomic, assign) BOOL isFitImage;

/**
 是否关闭图片加载动画
 */
@property (nonatomic, assign) BOOL isShowAnimation;
@end
