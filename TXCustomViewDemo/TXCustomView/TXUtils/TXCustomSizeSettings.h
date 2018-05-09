//
//  TXCustomSetupSettings.h
//  Lottery
//
//  Created by 新华龙mac on 2017/9/28.
//  Copyright © 2017年 新华龙mac. All rights reserved.
//  用于拓展自定义控件

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

static NSString *tx_key_size_Ooe = @"size_one";

@interface TXCustomSizeSettings : NSObject

#pragma mark -
#pragma mark - 下面三个属性为必需赋值的默认属性
/**
 一行有多少个
 */
@property (nonatomic, assign)NSInteger throwNumber;

/**
 照片之间的间隔
 */
@property (nonatomic, assign)NSInteger imageInterval;

/**
 默认图片尺寸(如果没有特殊要求，那么默认的图片的尺寸)
 */
@property (nonatomic, assign)CGSize defaultImageSize;

#pragma mark - 下面为拓展自定义属性
/**
 只有一张图片的时候的尺寸
 */
@property (nonatomic, assign)CGSize onlyOneImageSize;//imageSizeForOne

/**
 只有两张图片时候的尺寸
 */
@property (nonatomic, assign)CGSize onlyTwoImageSize;

/**
 只有三张图片时候的尺寸
 */
@property (nonatomic, assign)CGSize onlyThreeImageSize;

/**
 只有一排的时候尺寸
 */
@property (nonatomic, assign)CGSize frontRowImageSize;


@end
