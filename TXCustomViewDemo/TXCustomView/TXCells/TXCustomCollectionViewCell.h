//
//  TXCustomCollectionViewCell.h
//  Lottery
//
//  Created by 新华龙mac on 2017/12/26.
//  Copyright © 2017年 新华龙mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXCustomPhoto.h"

@protocol TXCustomCollectionViewCellDeleget <NSObject>

/**
 点击图片

 @param customImage 当前被点击的图片
 */
-(void)tapImageGes:(TXCustomPhoto *)customImage;

/**
 是否开始滑动

 @param flag 是否开始滑动
 */
-(void)slideRecognizerStateBegan:(BOOL )flag;

/**
 滑动的距离(需要提供给bg层)

 @param moveDistance 滑动的距离
 */
-(void)slideImageGes:(CGFloat )moveDistance;


/**
 退出预览模式

 @param rect 退出预览模式时，动画释放时的位置
 @param customImage 当前图片
 */
-(void)slideOutImageGesAnimationEndWithRect:(CGRect )rect withImage:(TXCustomPhoto *)customImage;

/**
 返回动画完成
 */
-(void)slideOutImageGesReturnAnimationEnd;

@end

@interface TXCustomCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak) id <TXCustomCollectionViewCellDeleget> deleget;
//是否需要长按拓展
@property (nonatomic, assign) BOOL closeLongPress;
//长按时间
@property (nonatomic, assign) CGFloat longPressDuration;
-(void)configImageWithImage:(TXCustomPhoto *)customImage
              longPressView:(UIView *)longPressView;
@end
