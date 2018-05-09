//
//  TXCustomImageSpecification.h
//  Lottery
//
//  Created by 新华龙mac on 2017/9/27.
//  Copyright © 2017年 新华龙mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TXCustomImageSpecification : NSObject
/**
 获取图片的大小，返回适配图片

 @param image 当前image
 @return 返回的尺寸
 */
+(CGRect )calculateImageSpecification:(UIImage *)image;
@end
