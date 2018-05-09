//
//  TXCustomTopView.m
//  TXCustomViewDemo
//
//  Created by 新华龙mac on 2018/3/1.
//  Copyright © 2018年 新华龙mac. All rights reserved.
//  这个页面根据喜好自己做吧。用block和代理就行了

#import "TXCustomTopView.h"
#import "TXCustomTools.h"

@implementation TXCustomTopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled = YES;
        [self createSelf];
    }
    return self;
}
-(void)createSelf{
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *imageCusetom = [[UIImage imageNamed:@"wl_news_delete"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [btnBack setImage:imageCusetom forState:UIControlStateNormal];
    btnBack.tintColor = [UIColor whiteColor];
    btnBack.frame = CGRectMake(20, 20, 24, 24);
    [btnBack addTarget:self action:@selector(btnBackClcick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btnBack];
    
    UIButton *btnMore = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnMore setImage:[UIImage imageNamed:@"detail_more"] forState:UIControlStateNormal];
    btnMore.frame = CGRectMake(SCREEN_WIDTH-13-50, 20, 50, 24);
    [self addSubview:btnMore];
    
    UILabel *label = [[UILabel alloc]init];
    label.frame =  CGRectMake(60, 20, 140, 24);
    label.text = @"自定义拓展view";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
}

-(void)btnBackClcick
{
    self.block();
}
@end
