//
//  TXCustomShowTools.h
//  cms
//
//  Created by 田鑫 on 2017/6/27.
//  Copyright © 2017年 新华龙. All rights reserved.
//  showTools.m 可以自己替换成自己的提示方式，我这里用的是SVProgressHUD。

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TXCustomShowTools : NSObject

extern void ShowSuccessStatus(NSString *statues);
extern void ShowErrorStatus(NSString *statues);
extern void ShowMaskStatus(NSString *statues);

extern void ShowMessage(NSString *statues);
extern void ShowMessageWithDuration(NSString *statues,NSTimeInterval duration);
extern void ShowProgress(CGFloat progress);

extern void DismissHud(void);

@end
