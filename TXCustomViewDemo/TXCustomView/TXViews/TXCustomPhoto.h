//
//  TXCustomImageView.h
//  Lottery
//
//  Created by 新华龙mac on 2017/9/27.
//  Copyright © 2017年 新华龙mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TXCustomPhoto : NSObject

@property (nonatomic, strong) NSURL *minUrl;//小图url
@property (nonatomic, strong) NSURL *maxUrl;//大图url
@property (nonatomic, strong) UIImage *minImage;//小图
@property (nonatomic, strong) UIImage *maxImage;//大图
@property (nonatomic, strong) NSString *photoDescription;//图片描述
@property (nonatomic, strong) UIImage *placeHolder;//占位图片
@property (nonatomic, assign) BOOL isSave;//是否已经保存
@property (nonatomic, assign) CGSize imageSize;//图片尺寸
@end
