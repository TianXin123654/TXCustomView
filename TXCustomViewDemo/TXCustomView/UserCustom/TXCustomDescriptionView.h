//
//  TXCustomDescriptionView.h
//  TXCustomViewDemo
//
//  Created by 新华龙mac on 2018/2/28.
//  Copyright © 2018年 新华龙mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXCustomDescriptionView : UIView

#pragma mark - TXCustomDescriptionView属性调整，我这里只提供了属性调整没有提供整个view出去，现目前只提供了这几个属性， 后期可以根据需要在进行调整
//描述view的颜色
@property (nonatomic, strong) UIColor *descriptionViewColor;
//描述lable字体的大小
@property (nonatomic, strong) UIFont  *descriptionLableFont;
//描述lable字体的透明度
@property (nonatomic, assign) CGFloat descriptionLableAlpha;
//描述lable字体的颜色
@property (nonatomic, strong) UIColor *descriptionLableColor;

#pragma mark - 配置数据
/**
 设置图片描述

 @param description 当前的图片描述
 @param totalNumber 总共多少张书
 @param atIndex 当前是哪一张
 */
-(void)setImageDescription:(NSString *)description
               totalNumber:(NSInteger )totalNumber
                   atIndex:(NSInteger )atIndex
               bottomHight:(CGFloat )bottomHight;
@end
