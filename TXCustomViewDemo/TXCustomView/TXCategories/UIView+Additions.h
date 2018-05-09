//
//  UIView+Additions.h
//  CqlivingCloud
//
//  Created by xinhualong on 16/4/27.
//  Copyright © 2016年 xinhualong. All rights reserved.
//  UIView添加属性, 使得storyboard右侧属性栏显示

#import <UIKit/UIKit.h>

@interface UIView (Additions)

@property (assign, nonatomic) IBInspectable CGFloat cornerRadius;
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;
@property (strong, nonatomic) IBInspectable UIColor *borderColor;

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

-(void)setViewCorner;
- (UIViewController *)firstAvailableUIViewController;
- (id)traverseResponderChainForUIViewController;

/**
 *  获取最上层的ViewController
 *
 *  @return 最上层viewController
 */
- (UIViewController *)getTopViewController;


+ (UIViewController *)getTopViewController_class;

@end
