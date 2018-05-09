//
//  TXCustomAlertView.h
//  Lottery
//
//  Created by 新华龙mac on 2018/1/8.
//  Copyright © 2018年 新华龙mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TXCustomAlertViewDeleget <NSObject>
-(void)clickAtIndexStr:(NSString *)title;
@end

@interface TXCustomAlertView : UIView

@property (nonatomic, weak) id <TXCustomAlertViewDeleget> deleget;

-(void)setCusttomlongPressView:(UIView *)longPressView;
-(void)setTitleArray:(NSArray <NSString *>*)titleArray
      andCanserTitle:(NSString *)canserTitle;

-(void)show;

-(void)hide;

@end
