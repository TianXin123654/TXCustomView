//
//  CMSVideoProgressView.m
//  cms
//
//  Created by 新华龙mac on 2017/10/19.
//  Copyright © 2017年 新华龙. All rights reserved.
//

#import "CMSVideoProgressView.h"
@interface CMSVideoProgressView ()

@property (nonatomic, assign) CGRect circlesSize;
//背景圆环
@property (nonatomic, strong) CAShapeLayer *backCircle;
//前面圆环
@property (nonatomic, strong) CAShapeLayer *foreCircle;
//最外面的圆环
@property (nonatomic, strong) CAShapeLayer *firstCircle;
@end
@implementation CMSVideoProgressView

+(instancetype)viewWithFrame:(CGRect)frame circlesSize:(CGRect)size{
    return [[self alloc] initWithFrame:frame circlesSize:size];
}

- (instancetype)initWithFrame:(CGRect)frame circlesSize:(CGRect)size
{
    self = [super initWithFrame:frame];
    if (self) {
        self.circlesSize = size;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addBackCircleWithSize:self.circlesSize.origin.x lineWidth:self.circlesSize.origin.y];
    [self addForeCircleWidthSize:self.circlesSize.size.width lineWidth:self.circlesSize.size.height];
    [self addFirstCircleWidthSize:self.circlesSize.size.width lineWidth:self.circlesSize.size.width-self.circlesSize.origin.x];
    self.layer.cornerRadius = 10;
    //阴影
    self.backgroundColor = [UIColor clearColor];
    self.backCircle.strokeColor = [UIColor colorWithRed:0.00f green:0.00f blue:0.00f alpha:0.6f].CGColor;
    
    self.foreCircle.lineCap = @"butt";
    self.foreCircle.strokeColor = [UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:0.6f].CGColor;;
    self.firstCircle.lineCap = @"butt";
    self.firstCircle.shadowColor = [UIColor whiteColor].CGColor;
    self.firstCircle.shadowRadius = 10;
    self.firstCircle.shadowOffset = CGSizeMake(0, 0);
    self.firstCircle.shadowOpacity = 1;
    self.firstCircle.strokeColor = [UIColor whiteColor].CGColor;;
}

//添加背景的圆环
-(void)addBackCircleWithSize:(CGFloat)radius lineWidth:(CGFloat)lineWidth{
    self.backCircle = [self createShapeLayerWithSize:radius lineWith:lineWidth color:[UIColor clearColor]];
    self.backCircle.strokeStart = 0;
    self.backCircle.strokeEnd = 1;
    [self.layer addSublayer:self.backCircle];
}

//前面的圆环
-(void)addForeCircleWidthSize:(CGFloat)radius lineWidth:(CGFloat)lineWidth{
    self.foreCircle = [self createShapeLayerWithSize:radius lineWith:lineWidth color:[UIColor clearColor]];
    
    self.foreCircle.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius)
                                                          radius:radius-lineWidth/2
                                                      startAngle:-M_PI/2
                                                        endAngle:M_PI/180*270
                                                       clockwise:YES].CGPath;
    self.foreCircle.strokeStart = 0;
    self.foreCircle.strokeEnd = 0.8;
    [self.layer addSublayer:self.foreCircle];
}

-(void)addFirstCircleWidthSize:(CGFloat)radius lineWidth:(CGFloat)lineWidth{
    self.firstCircle = [self createShapeLayerWithSize:radius lineWith:lineWidth color:[UIColor clearColor]];
    
    self.firstCircle.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius)
                                                           radius:radius-lineWidth/2
                                                       startAngle:-M_PI/2
                                                         endAngle:M_PI/180*270
                                                        clockwise:YES].CGPath;
    self.firstCircle.strokeStart = 0;
    self.firstCircle.strokeEnd = 0.8;
    [self.layer addSublayer:self.firstCircle];
    
}

//创建圆环
-(CAShapeLayer *)createShapeLayerWithSize:(CGFloat)radius lineWith:(CGFloat)lineWidth color:(UIColor *)color{
    CGRect foreCircle_frame = CGRectMake(self.bounds.size.width/2-radius,
                                         self.bounds.size.height/2-radius,
                                         radius*2,
                                         radius*2);
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = foreCircle_frame;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(radius, radius)
                                                        radius:radius-lineWidth/2
                                                    startAngle:0
                                                      endAngle:M_PI*2
                                                     clockwise:YES];
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.backgroundColor = [UIColor clearColor].CGColor;
    layer.strokeColor = color.CGColor;
    layer.lineWidth = lineWidth;
    layer.lineCap = @"round";
    
    return layer;
}

-(void)setProgressValue:(CGFloat)progressValue{
    if (self.foreCircle) {
        self.foreCircle.strokeEnd = progressValue;
        self.firstCircle.strokeEnd = progressValue;
    }
}

@end
