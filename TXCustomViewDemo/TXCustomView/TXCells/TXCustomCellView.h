//
//  TXCustomImageView1.h
//  Lottery
//
//  Created by 新华龙mac on 2017/12/28.
//  Copyright © 2017年 新华龙mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXCustomPhoto.h"

@protocol TXCustomCellViewDeleget <NSObject>

/**
 点击图片退出图片预览

 @param customImage 当前显示的图片
 */
-(void)customCelltapImageGes:(TXCustomPhoto *)customImage;

/**
 开始效果时，禁止UICollectionView 滑动，防止手势冲突.

 @param flag flag
 */
-(void)customCellslideRecognizerStateBegan:(BOOL )flag;//开始滑动；

/**
 滑动的距离，提供给外面进行涂层显示效果

 @param moveDistance moveDistance
 */
-(void)customCellslideImageGes:(CGFloat )moveDistance;//滑动的距离(需要提供给bg层)


/**
 退出图片预览（仿今日头条效果）

 @param rect 当前图片的位置
 @param customImage 当前显示的图片
 */
-(void)customCellslideOutImageGesAnimationEndWithRect:(CGRect )rect withImage:(TXCustomPhoto *)customImage;



-(void)customCellslideOutImageGesReturnAnimationEnd;//返回动画完成

@end

@interface TXCustomCellView : UIView
@property (nonatomic, weak) id <TXCustomCellViewDeleget> deleget;
@property (nonatomic, strong) TXCustomPhoto *customImage;
//外界传进来的longPressView
@property (nonatomic, strong) UIView *longPressView;
//是否需要长按拓展
@property (nonatomic, assign) BOOL closeLongPress;
//长按时间
@property (nonatomic, assign) CGFloat longPressDuration;
@property (nonatomic, assign) BOOL isxiaosguo;

@end
