//
//  LSCoreToolCenter.m
//  cms
//
//  Created by 田鑫 on 2017/6/27.
//  Copyright © 2017年 新华龙. All rights reserved.
//

#import "TXCustomShowTools.h"
#import <SVProgressHUD.h>

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

@implementation TXCustomShowTools

+ (void)load{
    
    [SVProgressHUD setBackgroundColor:RGBACOLOR(0, 0, 0, 0.8)];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setInfoImage:nil];
}

void ShowSuccessStatus(NSString *statues){
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showSuccessWithStatus:statues];
            [SVProgressHUD dismissWithDelay:1.2f];
        });
    }else{
        [SVProgressHUD showSuccessWithStatus:statues];
        [SVProgressHUD dismissWithDelay:1.2f];
    }
}


void ShowMessage(NSString *statues){
    ShowMessageWithDuration(statues, 1.2f);
}

void ShowMessageWithDuration(NSString *statues,NSTimeInterval duration){
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showInfoWithStatus:statues];
            [SVProgressHUD dismissWithDelay:duration];
        });
    }else{
        [SVProgressHUD showInfoWithStatus:statues];
        [SVProgressHUD dismissWithDelay:duration];
    }
}


void ShowErrorStatus(NSString *statues){
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showErrorWithStatus:statues];
            [SVProgressHUD showProgress:0.5 status:@"上传"];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
            [SVProgressHUD dismissWithDelay:1.2f];
        });
    }else{
        [SVProgressHUD showErrorWithStatus:statues];
        [SVProgressHUD dismissWithDelay:1.2f];
    }
}


void ShowMaskStatus(NSString *statues){
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            //            [SVProgressHUD showWithStatus:statues maskType:SVProgressHUDMaskTypeGradient];
            [SVProgressHUD showWithStatus:statues];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        });
    }else{
        //        [SVProgressHUD showWithStatus:statues maskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD showWithStatus:statues];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
    }
}

void ShowProgress(CGFloat progress){
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD showProgress:progress];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
            //            [SVProgressHUD showProgress:progress maskType:SVProgressHUDMaskTypeGradient];
        });
    }else{
        [SVProgressHUD showProgress:progress];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        //        [SVProgressHUD showProgress:progress maskType:SVProgressHUDMaskTypeGradient];
    }
}

void DismissHud(void){
    if (![NSThread isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }else{
        [SVProgressHUD dismiss];
    }
}

@end
