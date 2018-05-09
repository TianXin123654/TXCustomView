//
//  TXCustomView.h
//  Lottery
//
//  Created by 新华龙mac on 17/5/18.
//  Copyright © 2017年 新华龙mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TXCustomTools.h"
#import "TXCustomPhoto.h"
#import "TXCustomSizeSettings.h"
#import "TXCustomDescriptionView.h"

//内容展示方式
typedef NS_ENUM(NSInteger, CustomViewContentType) {
    CustomViewContentTypeDefault = 0, //默认展示模式
    CustomViewContentTypeDescription, //带有图片文字介绍模式
};//选中的是那一个排序方式

@protocol TXCustomViewDelegate<NSObject>
@optional
//提供给外界以做调整（CustomViewContentTypeDefault无效）
- (void)customViewDescriptionView:(TXCustomDescriptionView *)descriptionView;
//滑动到第几张
- (void)customViewSlideAtIndex:(NSInteger )index;
//开始预览
- (void)customViewBeginPreview;
//结束预览
- (void)customViewFinishPreview;
@end

@protocol TXCustomViewDataSource<NSObject>
@optional
//自定义顶部view
- (UIView *)customTopView;
//自定义底部view
- (UIView *)customBottomView;
//长按图片弹出View
- (UIView *)customLongPressView;
@end

@interface TXCustomView : UIView
//图片展示的类型
@property (nonatomic, assign) CustomViewContentType customViewContentType;
@property (nonatomic, weak) id <TXCustomViewDataSource> dataSource;
@property (nonatomic, weak) id <TXCustomViewDelegate> delegate;

//小于顶部距离，缩小动画回到正中
@property (nonatomic, assign) CGFloat lessThanTop;
//大于顶部距离，缩小动画回到正中
@property (nonatomic, assign) CGFloat lessThanBottom;
//是否需要长按拓展
@property (nonatomic, assign) BOOL closeLongPress;
//长按时间
@property (nonatomic, assign) CGFloat longPressDuration;
//退出预览模式
-(void)hideImage;


#pragma mark - 快速生成朋友圈九宫格图片布局(CustomViewContentTypeDefault)
/**
 快速生成图片框方法(类似九宫格 图片尺寸根据view给定的大小计算)
 
 @param imageArray TXCustomImageArray
 @param interval 图片之间的间距
 @param throwNumber 一排显示的数量
 @param isFit 是否铺满
 */
-(void)setImageArray:(NSArray<TXCustomPhoto *>*)imageArray
    andImageInterval:(NSInteger )interval
      andThrowNumber:(int )throwNumber
   andIsFitImageView:(BOOL)isFit;

/**
 快速生成图片框方法(类似九宫格 图片尺寸根据用户给定的imagesize大小生成)
 
 @param imageArray TXCustomImageArray
 @param sets sets TXCustomSetupSettings自定义拓展设置
 */
-(void)setCustomViewSizeWithImageArray:(NSArray<TXCustomPhoto *>*)imageArray
                           withSetting:(TXCustomSizeSettings *)sets;


#pragma mark - 展示图片浏览CustomViewContentTypeDescription

/**
 展示图片

 @param superImageView 父系图片
 @param customImages 需要展示的TXCustomImage数组
 */
-(void)showImageWithSuperView:(UIImageView *)superImageView
               TXCustomImages:(NSArray <TXCustomPhoto *>*)customImages;

@end
