//
//  UIAlertController+Additions.m
//  CqlivingCloud
//
//  Created by XHL on 2017/4/17.
//  Copyright © 2017年 xinhualong. All rights reserved.
//

#import "UIAlertController+Additions.h"

@implementation UIAlertController (Additions)

+ (UIAlertController *)alertWithTitle:(NSString *)title
                              message:(NSString *)msg
                            sureTitle:(NSString *)sure
                          cancelTitle:(NSString *)cancel
                          sureHandler:(ActionHandler)sureHandler
                        cancelHandler:(ActionHandler)cacelHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:msg
                                                            preferredStyle:UIAlertControllerStyleAlert];
    if (sure) {
        UIAlertAction *s = [UIAlertAction actionWithTitle:sure
                                                    style:UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction * _Nonnull action) {
                                                      if (sureHandler) {
                                                          sureHandler(action);
                                                      }
                                                  }];
        [alert addAction:s];
    }
    
    if (cancel) {
        
        UIAlertAction *c = [UIAlertAction actionWithTitle:cancel
                                                    style:UIAlertActionStyleCancel
                                                  handler:^(UIAlertAction * _Nonnull action) {
                                                      if (cacelHandler) {
                                                          cacelHandler(action);
                                                      }
                                                  }];
        
        [alert addAction:c];
    }
    
    return alert;
}

+(UIAlertController *)alertActionSheetWithTitle:(NSString *)title
                                        message:(NSString *)msg
                                    expandArray:(NSArray <NSString *>*)expandArray
                                    cancelTitle:(NSString *)cancel
                         alertDefaultColorArray:(NSArray <UIColor *>*)defaultColorArray
                               alertCancleColor:(UIColor *)cancleColor
                                  actionHandler:(ActionHandler)actionHandler{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:title
                                                                   message:msg
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i = 0; i<expandArray.count; i++) {
        UIAlertAction *b = [UIAlertAction actionWithTitle:expandArray[i]
                                                    style:UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction * _Nonnull action) {
                                                      if (actionHandler) {
                                                          actionHandler(action);
                                                      }
                                                  }];
        if (defaultColorArray.count == expandArray.count&&
            [defaultColorArray[i] isKindOfClass:[UIColor class]]) {
            [b setValue:defaultColorArray[i] forKey:@"_titleTextColor"];
        }
        [alertView addAction:b];
    }
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消"
                                                     style:UIAlertActionStyleCancel
                                                   handler:nil];
    [cancle setValue:cancleColor forKey:@"_titleTextColor"];
    [alertView addAction:cancle];
    return alertView;
}

@end
