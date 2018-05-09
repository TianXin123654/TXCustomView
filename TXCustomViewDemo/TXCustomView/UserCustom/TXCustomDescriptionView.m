//
//  TXCustomDescriptionView.m
//  TXCustomViewDemo
//
//  Created by 新华龙mac on 2018/2/28.
//  Copyright © 2018年 新华龙mac. All rights reserved.
//

#import "TXCustomDescriptionView.h"
#import "NSString+Additions.h"
#import "TXCustomTools.h"

@interface TXCustomDescriptionView()
@property (nonatomic, strong) UITextView *descriptionViewTF;
@property (nonatomic, strong) UIView *alphaView;
@end

@implementation TXCustomDescriptionView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)setImageDescription:(NSString *)description
               totalNumber:(NSInteger )totalNumber
                   atIndex:(NSInteger )atIndex
               bottomHight:(CGFloat )bottomHight
{
    CGFloat hight = [description calculateHeightWithWidth:self.frame.size.width-26 font:[UIFont systemFontOfSize:16]];
    hight =hight>120?120:hight;
    CGRect rectTemp = self.frame;
    rectTemp.size.height = hight+50;
    rectTemp.origin.y = SCREEN_HEIGHT -hight-50-bottomHight;
    self.frame = rectTemp;
    self.descriptionViewTF.text = [NSString stringWithFormat:@"%ld/%ld  %@",(long)atIndex,(long)totalNumber,description];
    [self addSubview:self.alphaView];
    [self.alphaView addSubview:self.descriptionViewTF];
    
}
////描述view的高度
//@property (nonatomic, assign) CGFloat descriptionViewHight;
////描述view的颜色
//@property (nonatomic, strong) UIColor *descriptionViewColor;
////描述lable字体的大小
//@property (nonatomic, strong) UIFont  *descriptionLableFont;
////描述lable字体的颜色
//@property (nonatomic, strong) UIColor *descriptionLableColor;

#pragma mark - setting
-(void)setDescriptionViewColor:(UIColor *)descriptionViewColor
{
    self.alphaView.backgroundColor = [descriptionViewColor colorWithAlphaComponent:0.6];
}
-(void)setDescriptionLableFont:(UIFont *)descriptionLableFont
{
    self.descriptionViewTF.font = descriptionLableFont;
}
- (void)setDescriptionLableAlpha:(CGFloat )descriptionLableAlpha
{
    self.descriptionViewTF.alpha = descriptionLableAlpha;
}
-(void)setDescriptionLableColor:(UIColor *)descriptionLableColor
{
    self.descriptionViewTF.textColor = descriptionLableColor;
}
#pragma mark - Lazy
-(UIView *)alphaView{
    if (!_alphaView) {
        _alphaView = [[UIView alloc]init];
        _alphaView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    }
    _alphaView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    return _alphaView;
}

-(UITextView*)descriptionViewTF{
    if (!_descriptionViewTF) {
        _descriptionViewTF = [[UITextView alloc]init];
        _descriptionViewTF.font = [UIFont systemFontOfSize:16];
        _descriptionViewTF.textColor = [UIColor whiteColor];
        _descriptionViewTF.backgroundColor = [UIColor clearColor];
    }
    _descriptionViewTF.frame = CGRectMake(13, 13, self.frame.size.width-26, self.frame.size.height-26);
    return _descriptionViewTF;
}

@end
