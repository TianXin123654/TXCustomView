//
//  TXCustomTools.h
//  Lottery
//
//  Created by 新华龙mac on 2017/9/28.
//  Copyright © 2017年 新华龙mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TXCustomSizeSettings.h"
#import "TXCustomPhoto.h"
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

typedef void (^OperationStatusBlock)(BOOL status);


@interface TXCustomTools : NSObject

/**
 获取view的大小
 
 @param imageCount 图片的个数
 @param sets  自定义设置(自定义设置里面的imageSize的优先级高于函数带有的imageSize)
 @return view的高度
 */
+(CGSize )getCustomViewSizeWithImageCount:(NSInteger )imageCount
                                  withSetting:(TXCustomSizeSettings *)sets;


/**
 保存图片

 @param customImage TXCustomImage
 @param status OperationStatusBlock
 */
+(void)saveImageToPhotoAlbumWithCustomImage:(TXCustomPhoto *)customImage
                         andOperationStatus:(OperationStatusBlock )status;
@end
