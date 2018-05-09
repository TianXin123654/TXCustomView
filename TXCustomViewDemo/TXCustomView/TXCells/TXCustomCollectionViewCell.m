//
//  TXCustomCollectionViewCell.m
//  Lottery
//
//  Created by 新华龙mac on 2017/12/26.
//  Copyright © 2017年 新华龙mac. All rights reserved.
//

#import "TXCustomCollectionViewCell.h"
#import "TXCustomCellView.h"
#import "TXCustomTools.h"
@interface TXCustomCollectionViewCell ()<TXCustomCellViewDeleget>

@property (nonatomic, strong) TXCustomCellView *customCellView;

@end

@implementation TXCustomCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

-(void)configImageWithImage:(TXCustomPhoto *)customImage
              longPressView:(UIView *)longPressView{
    self.customCellView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.customCellView.customImage = customImage;
    self.customCellView.deleget = self;
    self.customCellView.longPressView = longPressView;
    [self addSubview:self.customCellView];
}

- (void)setCloseLongPress:(BOOL)closeLongPress
{
    self.customCellView.closeLongPress = closeLongPress;
}

- (void)setLongPressDuration:(CGFloat)longPressDuration
{
    self.customCellView.longPressDuration = longPressDuration;
}

-(void)customCelltapImageGes:(TXCustomPhoto *)customImage{
    [self.deleget tapImageGes:customImage];
}

//开始滑动；
-(void)customCellslideRecognizerStateBegan:(BOOL )flag{
    [self.deleget slideRecognizerStateBegan:flag];
}

//滑动的距离(需要提供给bg层)
-(void)customCellslideImageGes:(CGFloat )moveDistance{
    [self.deleget slideImageGes:moveDistance];
}

//结束动画完成
-(void)customCellslideOutImageGesAnimationEndWithRect:(CGRect)rect withImage:(TXCustomPhoto *)customImage{
    [self.deleget slideOutImageGesAnimationEndWithRect:rect withImage:customImage];
}

//返回动画完成
-(void)customCellslideOutImageGesReturnAnimationEnd{
    [self.deleget slideOutImageGesReturnAnimationEnd];
}

#pragma mark - Lazy
-(TXCustomCellView *)customCellView{
    if (!_customCellView) {
        _customCellView = [[TXCustomCellView alloc]init];
    }
    return _customCellView;
}
@end
