//
//  UIAlertController+Additions.h
//  CqlivingCloud
//
//  Created by XHL on 2017/4/17.
//  Copyright © 2017年 xinhualong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ActionHandler)(UIAlertAction *action);
@interface UIAlertController (Additions)


/**
 UIAlertControllerStyleAlert

 @param title 标题
 @param msg 详情
 @param sure 确定标题
 @param cancel 取消标题
 @param sureHandler 确定回调
 @param cacelHandler 取消回调
 @return UIAlertController(类型为UIAlertControllerStyleAlert)
 */
+ (UIAlertController *)alertWithTitle:(NSString *)title
                              message:(NSString *)msg
                            sureTitle:(NSString *)sure
                          cancelTitle:(NSString *)cancel
                          sureHandler:(ActionHandler)sureHandler
                        cancelHandler:(ActionHandler)cacelHandler;




/**
 UIAlertControllerStyleActionSheet

 @param title 标题
 @param msg 详情
 @param expandArray 选择按钮
 @param cancel 取消按钮
 @param defaultColorArray defaultColorArray
 @param cancleColor 取消按钮颜色
 @param actionHandler 返回点击ActionHandler
 @return UIAlertController
 */
+(UIAlertController *)alertActionSheetWithTitle:(NSString *)title
                                        message:(NSString *)msg
                                    expandArray:(NSArray <NSString *>*)expandArray
                                    cancelTitle:(NSString *)cancel
                         alertDefaultColorArray:(NSArray <UIColor *>*)defaultColorArray
                               alertCancleColor:(UIColor *)cancleColor
                                  actionHandler:(ActionHandler)actionHandler;
@end
