//
//  TXCustomImageView.h
//  Lottery
//
//  Created by 新华龙mac on 2017/9/27.
//  Copyright © 2017年 新华龙mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXCustomPhoto.h"

typedef void (^LoadImageStatusBlock)(BOOL isSucceed, UIImage *image, CGFloat progress);

@interface TXCustomImageView : UIImageView


/**
 加载小图

 @param TXImage TXCustomImage
 @param LoadImageStatusBlock LoadImageStatusBlock description
 */
-(void)loadMinImage:(TXCustomPhoto *)TXImage andLoadImageStatusBlock:(LoadImageStatusBlock )LoadImageStatusBlock;


/**
 加载大图

 @param TXImage TXCustomImage
 @param LoadImageStatusBlock LoadImageStatusBlock description
 */
-(void)loadMaxImage:(TXCustomPhoto *)TXImage andLoadImageStatusBlock:(LoadImageStatusBlock )LoadImageStatusBlock;


///**
// 加载图片（哪一种有内容加载哪一种，默认大图）
//
// @param TXImage TXCustomImage
// @param LoadImageStatusBlock LoadImageStatusBlock description
// */
//-(void)loadImage:(TXCustomImage *)TXImage andLoadImageStatusBlock:(LoadImageStatusBlock )LoadImageStatusBlock;

@end
