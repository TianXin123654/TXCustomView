//
//  TXCustomImageView1.m
//  Lottery
//
//  Created by 新华龙mac on 2017/12/28.
//  Copyright © 2017年 新华龙mac. All rights reserved.
//

#import "TXCustomCellView.h"
#import "TXCustomImageView.h"
#import "TXCustomImageSpecification.h"

#import "UIAlertController+Additions.h"
#import "UIView+Additions.h"
#import "TXCustomAlertView.h"

#import "TXCustomTools.h"
#import "TXCustomShowTools.h"
#import "CMSVideoProgressView.h"
typedef NS_ENUM(NSInteger, imageViewGestureStuats){
    ImageViewStuats_await = 0,     //图片原始状态
    ImageViewStuats_scrollView,    //图片正在放大缩小
    ImageViewStuats_collectionView,//图片正在滑动中
    ImageViewStuats_moveImage      //图片正在拖动中
};//imageView当前手势

@interface TXCustomCellView()<
UIGestureRecognizerDelegate,
UIScrollViewDelegate,
UIGestureRecognizerDelegate,
TXCustomAlertViewDeleget>

@property (nonatomic, assign) imageViewGestureStuats imageViewGestureStuat;
@property (nonatomic, strong) TXCustomPhoto *customImageTemp;
@property (nonatomic, strong) TXCustomImageView *imageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) TXCustomAlertView *alerView;
@property (nonatomic, strong) CMSVideoProgressView *progressView;
//@property (nonatomic, strong) UIView *longPressViewD;

@property (nonatomic, assign) BOOL isImageCollectionView;//是否持有图片滑动
@property (nonatomic, assign) BOOL isImageMoveImage;     //是否持有图片拖动
@property (nonatomic, assign) BOOL isLoadFinsh;//是否图片加载完成

@property (nonatomic, assign) CGRect fatherRect;//图片的最中间的位置
@property (nonatomic, assign) CGRect scrollViewImageRect;//记录放大图片的坐标

@property (nonatomic, assign) CGPoint lasttimePoint;//
@property (nonatomic, assign) CGPoint imageViewCenter;//最原始的坐标中心点
@property (nonatomic, assign) CGPoint imageViewCenterTemp;//当前的坐标中心点
@end

@implementation TXCustomCellView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        pan.delegate = self;
        [self addGestureRecognizer:pan];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(TXCollectionViewScroll) name:@"TXCollectionViewScroll" object:nil];
    }
    return self;
}

-(void)TXCollectionViewScroll
{
    [UIView animateWithDuration:0.5 animations:^{
        self.imageView.frame = self.fatherRect;
        self.scrollView.contentSize = CGSizeMake(self.imageView.frame.size.width, self.imageView.frame.size.height);
        self.scrollView.zoomScale = 1;
        self.imageViewGestureStuat = ImageViewStuats_await;
    }];
}

#pragma mark - configUi
-(void)setCustomImage:(TXCustomPhoto *)customImage
{
    self.progressView = nil;
    //这里的代码以后需要优化一下。先将就用吧
    self.customImageTemp  = customImage;
    __weak typeof(self) weakSelf = self;
    //1.加载本地默认图，并配置imageView的大小
    if (self.customImageTemp.placeHolder) {
        self.imageView.image = self.customImageTemp.placeHolder;
        self.imageView.frame = [TXCustomImageSpecification calculateImageSpecification:self.customImageTemp.placeHolder];
       self.scrollView.maximumZoomScale = 1;//图片放大最大阈值
    }
    //2.判断是否已经有大图。如果已经有大图则加载。
    if (self.customImageTemp.maxImage) {
        self.scrollView.maximumZoomScale = 8;//图片放大最大阈值
        self.imageView.image = self.customImageTemp.maxImage;
        if (self.imageViewGestureStuat == ImageViewStuats_scrollView) {
            self.imageView.frame = self.scrollViewImageRect;
        }else{
            self.imageView.frame = [TXCustomImageSpecification calculateImageSpecification:self.customImageTemp.maxImage];
        }
    }else if (self.customImageTemp.minImage) {//判断是否存在小图，如果小图存在，则判断是否存在大图链接，如果大图链接存在，则开始加载大图。
        self.scrollView.maximumZoomScale = 8;//图片放大最大阈值
        self.imageView.image = self.customImageTemp.minImage;
        if (self.imageViewGestureStuat == ImageViewStuats_scrollView) {
            self.imageView.frame = self.scrollViewImageRect;
        }else{
            self.imageView.frame = [TXCustomImageSpecification calculateImageSpecification:self.customImageTemp.minImage];
        }
        self.customImageTemp.placeHolder =self.customImageTemp.minImage;
        if (self.customImageTemp.maxUrl) {
            self.progressView.progressValue = 0;
            self.progressView.hidden = NO;
            self.isLoadFinsh = YES;
            [self.imageView loadMaxImage:self.customImageTemp andLoadImageStatusBlock:^(BOOL isSucceed, UIImage *image, CGFloat progress) {
                weakSelf.progressView.progressValue = progress;
                if (isSucceed) {
                    weakSelf.isLoadFinsh = NO;
                    if (weakSelf.imageViewGestureStuat == ImageViewStuats_scrollView) {
                        weakSelf.imageView.frame = weakSelf.scrollViewImageRect;
                    }else{
                        weakSelf.imageView.frame = [TXCustomImageSpecification calculateImageSpecification:image];
                        weakSelf.fatherRect = weakSelf.imageView.frame;
                    }
                    self.progressView.hidden = YES;
                    weakSelf.customImageTemp.maxImage = image;
                    weakSelf.customImageTemp.placeHolder = image;
                    [weakSelf returnConfig:weakSelf.imageViewGestureStuat];
                }
            }];
        }
    }else if (self.customImageTemp.maxUrl){//判断大图链接是否存在，如果大图链接存在，则直接加载大图
        self.progressView.progressValue = 0;
        self.progressView.hidden = NO;
        self.scrollView.maximumZoomScale = 8;//图片放大最大阈值
        self.isLoadFinsh = YES;
        [self.imageView loadMaxImage:self.customImageTemp andLoadImageStatusBlock:^(BOOL isSucceed, UIImage *image, CGFloat progress) {
            weakSelf.progressView.progressValue = progress;
            if (isSucceed) {
                weakSelf.isLoadFinsh = NO;
                if (weakSelf.imageViewGestureStuat == ImageViewStuats_scrollView) {
                    weakSelf.imageView.frame = weakSelf.scrollViewImageRect;
                    weakSelf.fatherRect = [TXCustomImageSpecification calculateImageSpecification:image];
                }else{
                    weakSelf.imageView.frame = [TXCustomImageSpecification calculateImageSpecification:image];
                }
               self.progressView.hidden = YES;
                weakSelf.customImageTemp.maxImage = image;
                weakSelf.customImageTemp.placeHolder = image;
                [weakSelf returnConfig:weakSelf.imageViewGestureStuat];
            }
        }];
    }else{//默认加载小图链接
        self.progressView.progressValue = 0;
        self.progressView.hidden = NO;
        self.scrollView.maximumZoomScale = 8;//图片放大最大阈值
        self.isLoadFinsh = YES;
        [self.imageView loadMinImage:self.customImageTemp andLoadImageStatusBlock:^(BOOL isSucceed, UIImage *image, CGFloat progress) {
            weakSelf.progressView.progressValue = progress;
            if (isSucceed) {
                weakSelf.isLoadFinsh = NO;
                if (weakSelf.imageViewGestureStuat == ImageViewStuats_scrollView) {
                    weakSelf.imageView.frame = weakSelf.scrollViewImageRect;
                    weakSelf.fatherRect = [TXCustomImageSpecification calculateImageSpecification:image];
                }else{
                    weakSelf.imageView.frame = [TXCustomImageSpecification calculateImageSpecification:image];
                }
                self.progressView.hidden = YES;
                weakSelf.customImageTemp.minImage = image;
                weakSelf.customImageTemp.placeHolder = image;
                [weakSelf returnConfig:weakSelf.imageViewGestureStuat];

            }
        }];
    }
    [self returnConfig:self.imageViewGestureStuat];

}

//刷新配置
-(void)returnConfig:(imageViewGestureStuats )stuat{
    if (stuat != ImageViewStuats_scrollView) {
        self.fatherRect = self.imageView.frame;
    }
    self.scrollView.frame = self.frame;
    self.imageViewCenter = self.imageView.center;
    self.imageViewGestureStuat = stuat;
    self.scrollView.contentSize = CGSizeMake(self.imageView.frame.size.width, self.imageView.frame.size.height);
    [self addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
    [self addSubview:self.progressView];
}

#pragma mark - UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if (self.imageViewGestureStuat == ImageViewStuats_moveImage) {
        return nil;
    }
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGRect frame = self.imageView.frame;
    frame.origin.y = (self.scrollView.frame.size.height - self.imageView.frame.size.height) > 0 ? (self.scrollView.frame.size.height - self.imageView.frame.size.height) * 0.5 : 0;
    frame.origin.x = (self.scrollView.frame.size.width - self.imageView.frame.size.width) > 0 ? (self.scrollView.frame.size.width - self.imageView.frame.size.width) * 0.5 : 0;
    self.imageView.frame = frame;
    self.scrollView.contentSize = CGSizeMake(self.imageView.frame.size.width, self.imageView.frame.size.height);
    self.scrollViewImageRect = self.imageView.frame;
    CGFloat contentSizeW = self.scrollView.contentSize.width;
    CGFloat contentSizeH = self.scrollView.contentSize.height;
    if (contentSizeW>self.fatherRect.size.width||
        contentSizeH>self.fatherRect.size.height) {
        self.imageViewGestureStuat = ImageViewStuats_scrollView;
    }else{
        self.imageViewGestureStuat = ImageViewStuats_await;
    }
}

//手势冲突
-(BOOL)gestureRecognizer:(UIGestureRecognizer*) gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer*)otherGestureRecognizer
{
    if ([gestureRecognizer.view isKindOfClass:[UICollectionView class]]) {
        return NO;
    }else{
        return YES;
    }
}

/**
 拦截手势

 */
-(void)interceptGestureWithGesture:(UIPanGestureRecognizer *)gesture
{
    [self.deleget customCellslideRecognizerStateBegan:YES];
    CGPoint point = [gesture translationInView:self];
    CGFloat contentSizeW = self.scrollView.contentSize.width;
    CGFloat contentSizeH = self.scrollView.contentSize.height;
    if (contentSizeW>self.fatherRect.size.width||
        contentSizeH>self.fatherRect.size.height||
        contentSizeW<self.fatherRect.size.width||
        contentSizeH<self.fatherRect.size.height) {
        if (self.isImageMoveImage) {
            self.imageViewGestureStuat = ImageViewStuats_moveImage;
            self.isImageMoveImage = YES;
        }else{
            self.imageViewGestureStuat = ImageViewStuats_scrollView;
        }
    }else if (self.isImageMoveImage){
        self.imageViewGestureStuat = ImageViewStuats_moveImage;
        self.isImageMoveImage = YES;
    }else if (self.isImageCollectionView){
        self.imageViewGestureStuat = ImageViewStuats_collectionView;
        self.isImageCollectionView = YES;
    }else if (fabs(point.x)>0){
        self.imageViewGestureStuat = ImageViewStuats_collectionView;
        self.isImageCollectionView = YES;
    }else if (fabs(point.y)>0){
        self.imageViewGestureStuat = ImageViewStuats_moveImage;
        self.isImageMoveImage = YES;
    }else{
        self.imageViewGestureStuat = ImageViewStuats_await;
    }
}

/**
 滑动手势
 
 @param gesture UIPanGestureRecognizer
 */
- (void)panAction:(UIPanGestureRecognizer *)gesture {
    [self interceptGestureWithGesture:gesture];
    if (self.imageViewGestureStuat == ImageViewStuats_await) {
//        NSLog(@"图片原始状态");
    }else if (self.imageViewGestureStuat == ImageViewStuats_scrollView){
//        NSLog(@"图片正在放大缩小");
    }else if (self.imageViewGestureStuat == ImageViewStuats_collectionView){
//        NSLog(@"图片正在滑动中");
    }else if (self.imageViewGestureStuat == ImageViewStuats_moveImage){
//        NSLog(@"图片正在拖动中");
    }
    
    CGPoint point = [gesture translationInView:self];
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
//            self.progressView.alpha = 0;
            if (self.imageViewGestureStuat == ImageViewStuats_moveImage||
                self.imageViewGestureStuat == ImageViewStuats_await) {
                if (fabs(point.y)>0) {
                    [self.deleget customCellslideRecognizerStateBegan:NO];
                }else
                {
                    [self.deleget customCellslideRecognizerStateBegan:YES];
                }
            }
        }
            break;
            
        case UIGestureRecognizerStateChanged:
        {
            if (self.imageViewGestureStuat == ImageViewStuats_moveImage||
                self.imageViewGestureStuat == ImageViewStuats_await) {
                self.progressView.hidden = YES;
                if (fabs(point.y)>0) {
                    [self.deleget customCellslideRecognizerStateBegan:NO];
                }else
                {
                    [self.deleget customCellslideRecognizerStateBegan:YES];
                }
                [self.deleget customCellslideImageGes:fabs(point.y)];
                if (!self.isxiaosguo) {
                    [self moveImageViewWithPoint:point];
                }else{
                    [self moveImageViewDistance:point.y - self.lasttimePoint.y];
                }
            }
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        {
//            self.progressView.alpha = 1;
            self.isImageMoveImage = NO;
            self.isImageCollectionView = NO;
            if (self.imageViewGestureStuat == ImageViewStuats_moveImage||
                self.imageViewGestureStuat == ImageViewStuats_await) {
                self.imageViewGestureStuat = ImageViewStuats_await;
                self.progressView.hidden = !self.isLoadFinsh;
                if(fabs(point.y) > SCREEN_HEIGHT / 4) {
                    [self.deleget customCellslideOutImageGesAnimationEndWithRect:self.imageView.frame withImage:self.customImageTemp];
                } else {
                    [self.deleget customCellslideOutImageGesReturnAnimationEnd];
                    [UIView animateWithDuration:0.25
                                     animations:^{
                                         self.imageView.frame = self.fatherRect;
                                     }
                                     completion:^(BOOL finished) {
                                         
                                     }];
                }
            }
        }
            break;
        default:
            break;
    }
    self.lasttimePoint = point;
}

-(void)moveImageViewWithPoint:(CGPoint )point{
    CGFloat point_x = point.x;
    CGFloat point_y = point.y;
    CGFloat point_yy =0;
    if (point_y<0) {
        point_yy = -point_y;
    }else{
        point_yy = point_y;
    }
    point_yy =  (1-point_yy/500);
    CGFloat imageViewWidth = self.fatherRect.size.width*point_yy;
    CGFloat imageViewHeight = self.fatherRect.size.height*point_yy;
    CGFloat x = self.imageViewCenter.x;
    CGFloat y = self.imageViewCenter.y;
    self.imageViewCenterTemp = CGPointMake(x+point_x, y+point_y);
    self.imageView.frame = CGRectMake(0, 0, imageViewWidth, imageViewHeight);
    self.imageView.center = CGPointMake(self.imageViewCenterTemp.x, self.imageViewCenterTemp.y);
}

- (void)moveImageViewDistance:(CGFloat)distance {
    self.imageView.frame = CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y + distance, self.imageView.frame.size.width, self.imageView.frame.size.height);
}

#pragma mark - TXCustomCellViewDeleget
//点击图片
-(void)tapGes
{
    if (self.imageViewGestureStuat == ImageViewStuats_scrollView) {
        [self TXCollectionViewScroll];
        [self TXCollectionViewScroll];
        return;
    }else{
        [self.deleget customCelltapImageGes:self.customImageTemp];
    }
}
-(void)longPressView:(UILongPressGestureRecognizer *)longGesture
{
    if (longGesture.state != UIGestureRecognizerStateBegan) {
        return;
    }
    NSArray *titleArray = [NSArray arrayWithObjects:@"保存(自定义拓展view)",@"分享", nil];
    self.alerView = [[TXCustomAlertView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.alerView.deleget = self;
    if (self.longPressView) {
        [self.alerView setCusttomlongPressView:self.longPressView];
    }else{
        [self.alerView setTitleArray:titleArray andCanserTitle:@"取消"];
    }
    [self.window addSubview:self.alerView];
    [self.alerView show];
}
#pragma mark - TXCustomCellViewDeleget
-(void)clickAtIndexStr:(NSString *)title{
    if ([title isEqualToString:@"保存(自定义拓展view)"]) {
        [TXCustomTools saveImageToPhotoAlbumWithCustomImage:self.customImageTemp andOperationStatus:^(BOOL status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.alerView hide];
            });
            if (status) {
                ShowSuccessStatus(@"保存成功");
            }else{
                ShowErrorStatus(@"保存失败");
            }
        }];
    }else if ([title isEqualToString:@"分享"]){
        ShowMessage(@"展示按钮，请自己添加");
    }
}

#pragma  mark - Lazy
-(TXCustomImageView *)imageView{
    if (!_imageView) {
        _imageView = [[TXCustomImageView alloc]init];
        _imageView.userInteractionEnabled = YES;
        //图片的点击手势
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGes)];
        [_imageView addGestureRecognizer:ges];
        if (!self.closeLongPress) {
            UILongPressGestureRecognizer *longPressGest = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressView:)];
            longPressGest.minimumPressDuration = self.longPressDuration?self.longPressDuration:1;
            longPressGest.allowableMovement = 30;
            [_imageView addGestureRecognizer:longPressGest];
        }
    }
    return _imageView;
}

-(UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.minimumZoomScale = 0.8;//图片缩小最小阈值
        _scrollView.maximumZoomScale = 8;//图片放大最大阈值
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
    }
    return _scrollView;
}

#pragma  mark - Lazy
-(CMSVideoProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [CMSVideoProgressView viewWithFrame:CGRectMake(self.frame.size.width/2-25/2, self.frame.size.height/2-25/2,25, 25) circlesSize:CGRectMake(20, 20, 25, 25)];
        _progressView.hidden = YES;
        _progressView.progressValue = 0;
    }
    return _progressView;
}
@end
