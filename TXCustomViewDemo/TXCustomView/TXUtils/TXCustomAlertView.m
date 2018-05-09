//
//  TXCustomAlertView.m
//  Lottery
//
//  Created by 新华龙mac on 2018/1/8.
//  Copyright © 2018年 新华龙mac. All rights reserved.
//

#import "TXCustomAlertView.h"
#import "TXCustomTools.h"
#define btnTag 100050

@interface TXCustomAlertView()
@property (nonatomic, strong) NSArray  *titleArray;
@property (nonatomic, strong) NSString *canserTitle;
@property (nonatomic, strong) UIView   *bgView;
@end

@implementation TXCustomAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUi];
    }
    return self;
}

#pragma mark - configUi
//配置初始化
-(void)configUi{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    [self addGestureRecognizer:ges];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.bgView = [[UIView alloc]init];
    self.bgView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.bgView];
}

-(void)setCusttomlongPressView:(UIView *)longPressView{
    self.bgView.frame = CGRectMake(0, self.frame.size.height+longPressView.frame.size.height, self.frame.size.width, longPressView.frame.size.height);
    [self.bgView addSubview:longPressView];
}

-(void)setTitleArray:(NSArray<NSString *> *)titleArray andCanserTitle:(NSString *)canserTitle{
    self.titleArray = titleArray;
    self.canserTitle = canserTitle;

    self.bgView.frame = CGRectMake(0, self.frame.size.height+((titleArray.count+1)*50+3), self.frame.size.width, (titleArray.count+1)*50+3);

    CGFloat btnHight = 50;
    for (int i = 0; i<titleArray.count+1; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = [UIColor whiteColor];
        btn.tag = btnTag + i;
        [btn addTarget:self action:@selector(btnClcick:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.bgView addSubview:btn];
        if (i < titleArray.count) {
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            btn.frame = CGRectMake(0, 0+i*btnHight, SCREEN_WIDTH, btnHight);
            UILabel *line = [[UILabel alloc]init];
            line.frame = CGRectMake(0, 0+i*btnHight, SCREEN_WIDTH, 0.5);
            line.backgroundColor = [UIColor grayColor];
            [ self.bgView addSubview:line];
        }else{
            [btn setTitle:canserTitle forState:UIControlStateNormal];
            btn.frame = CGRectMake(0, 0+i*btnHight+3, SCREEN_WIDTH, btnHight);
        }
    }
}

#pragma mark - Action


-(void)btnClcick:(UIButton *)btn{
    NSInteger index = btn.tag-btnTag;
    [self.deleget clickAtIndexStr:btn.titleLabel.text];
    if (index >= self.titleArray.count) {
        [self hide];
    }
}
-(void)show{
    CGRect rect = self.bgView.frame;
    rect.origin.y = self.frame.size.height-self.bgView.frame.size.height;
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.frame = rect;
    }];
}
-(void)hide{
    CGRect rect = self.bgView.frame;
    rect.origin.y = self.frame.size.height+self.bgView.frame.size.height;
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.frame = rect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
@end
