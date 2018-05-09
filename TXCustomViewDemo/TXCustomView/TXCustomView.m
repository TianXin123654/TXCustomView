//
//  TXCustomView.m
//  Lottery
//
//  Created by 新华龙mac on 17/5/18.
//  Copyright © 2017年 新华龙mac. All rights reserved.
//

#import "TXCustomView.h"
#import "TXCustomImageView.h"
#import "TXCustomImageSpecification.h"

#import "TXCustomCollectionViewCell.h"

#define imageViewTag 12000

@interface TXCustomView ()<UICollectionViewDelegateFlowLayout,
UICollectionViewDataSource,
UICollectionViewDelegate,
UIScrollViewDelegate,
TXCustomCollectionViewCellDeleget>

@property (strong, nonatomic) UICollectionView *imageCollection;
@property (nonatomic, strong) TXCustomImageView *customImageViewTemp;//点击的image
@property (nonatomic, strong) TXCustomImageView *customimageAnimation;//作为动画使用的
@property (nonatomic, strong) TXCustomDescriptionView *customDescriptionView;//图片描述

@property (nonatomic, strong) UIView *customBottomView;
@property (nonatomic, strong) UIView *customTopView;
@property (nonatomic, strong) UIView  *coverView;//背景虚化图

@property (nonatomic, assign) CGFloat intervalTemp;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSMutableArray *imageRectArray;

@property (nonatomic, assign) NSInteger showImageindex;
@property (nonatomic, strong) UIPageControl *collectionPage;

@property (nonatomic, assign) BOOL animationClash;//动画结束

@end

@implementation TXCustomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)showImageWithSuperView:(UIImageView *)superImageView
               TXCustomImages:(NSArray<TXCustomPhoto *> *)customImages
{
    if (!self.animationClash) {
        self.imageArray = customImages;
        self.customImageViewTemp = (TXCustomImageView *)superImageView;
        self.customImageViewTemp.tag = imageViewTag;
        self.showImageindex = 0;
        superImageView.hidden = YES;
        [self showImageWithIndex:0];
    }
}

-(void)setImageArray:(NSArray<TXCustomPhoto *>*)imageArray
    andImageInterval:(NSInteger )interval
      andThrowNumber:(int )throwNumber
   andIsFitImageView:(BOOL)isFit
{
//    if (interval==0||interval>50) {
//        self.intervalTemp = 5.0;
//    }else{
        self.intervalTemp = interval;
//    }
    
    NSInteger indexMany = imageArray.count/throwNumber;
    self.imageArray = imageArray;
    if (imageArray.count%throwNumber>0) {
        indexMany+=1;
    }
    CGFloat width;
    width = (self.frame.size.width-(throwNumber-1)*self.intervalTemp)/throwNumber;
    if (isFit && indexMany==1) {
        width = (self.frame.size.width-(imageArray.count-1)*self.intervalTemp)/imageArray.count;
    }
    CGFloat height = (self.frame.size.height-(indexMany-1)*self.intervalTemp)/indexMany;
    for (int i = 0; i<imageArray.count; i++) {
        TXCustomPhoto *customImage = imageArray[i];
        TXCustomImageView *imageview = [[TXCustomImageView alloc]init];
        imageview.contentMode=UIViewContentModeScaleAspectFill;
        imageview.clipsToBounds = YES;
        imageview.userInteractionEnabled = YES;
        imageview.frame =CGRectMake(i % throwNumber * (width + self.intervalTemp), i/throwNumber * (height+self.intervalTemp), width, height);
        [imageview loadMinImage:customImage andLoadImageStatusBlock:^(BOOL isSucceed, UIImage *image, CGFloat progress) {
            if (isSucceed) {
                customImage.minImage = image;
                customImage.placeHolder = image;
            }
        }];
        imageview.tag = imageViewTag+i;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gesTouchZoom:)];
        [imageview addGestureRecognizer:ges];
        [self addSubview:imageview];
    }
}

-(void)setCustomViewSizeWithImageArray:(NSArray<TXCustomPhoto *>*)imageArray
                           withSetting:(TXCustomSizeSettings *)sets
{
    CGSize ImageSize;
    NSInteger imageInterval = sets.imageInterval;
    NSInteger index;
    self.imageArray = imageArray;
    index = imageArray.count/sets.throwNumber;
    if (imageArray.count%sets.throwNumber>0) {
        index += 1;
    }
    if (imageArray.count == 1) {
        ImageSize = sets.onlyOneImageSize;
    }else if (imageArray.count == 2){
        ImageSize = sets.onlyTwoImageSize;
    }else if (imageArray.count == 3){
        ImageSize = sets.onlyThreeImageSize;
    }else if (index == 1){
        ImageSize = sets.frontRowImageSize;
    }else{
        ImageSize = sets.defaultImageSize;
    }
    for (int i = 0; i<imageArray.count; i++) {
        TXCustomPhoto *customImage = imageArray[i];
        TXCustomImageView *imageview = [[TXCustomImageView alloc]init];
        imageview.contentMode=UIViewContentModeScaleAspectFill;
        imageview.clipsToBounds = YES;
        imageview.userInteractionEnabled = YES;
        imageview.frame =CGRectMake(i % sets.throwNumber * (imageInterval+ImageSize.width), i/ sets.throwNumber * (imageInterval+ImageSize.height), ImageSize.width, ImageSize.height);
        [imageview loadMinImage:customImage andLoadImageStatusBlock:^(BOOL isSucceed, UIImage *image, CGFloat progress) {
            if (isSucceed) {
                customImage.minImage = image;
                customImage.placeHolder = image;
            }
        }];
        imageview.tag = imageViewTag+i;
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gesTouchZoom:)];
        [imageview addGestureRecognizer:ges];
        [self addSubview:imageview];
    }
}

/**
 创建图片的底部详情
 */
-(void)configBottomView
{
    if (self.customViewContentType == CustomViewContentTypeDefault) {
        [[self frontWindow] addSubview:self.collectionPage];
        self.collectionPage.hidden = NO;
        self.collectionPage.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 5);
    }else{
        TXCustomPhoto *image = self.imageArray[0];
        [self.customDescriptionView setImageDescription:image.photoDescription
                                            totalNumber:self.imageArray.count
                                                atIndex:1
                                            bottomHight:self.customBottomView.frame.size.height];
        [self.delegate customViewDescriptionView:self.customDescriptionView];
        [[self frontWindow] addSubview:self.customDescriptionView];
        [[self frontWindow] addSubview:self.customTopView];
        [[self frontWindow] addSubview:self.customBottomView];
    }
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.showImageindex = (NSInteger)(scrollView.contentOffset.x / SCREEN_WIDTH);
    [self setImageHiddenWith:self.showImageindex];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"TXCollectionViewScroll" object:nil];
    self.collectionPage.currentPage = self.showImageindex;
    if (self.customViewContentType == CustomViewContentTypeDescription) {
        TXCustomPhoto *image = self.imageArray[self.showImageindex];
        [self.customDescriptionView setImageDescription:image.photoDescription
                                            totalNumber:self.imageArray.count
                                                atIndex:self.showImageindex+1
                                            bottomHight:self.customBottomView.frame.size.height];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.showImageindex = (NSInteger)(scrollView.contentOffset.x / SCREEN_WIDTH);
    [self.delegate customViewSlideAtIndex:self.showImageindex];
}

#pragma mark - UICollectionView Delegate/DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TXCustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TXCustomCollectionViewCell" forIndexPath:indexPath];
    cell.closeLongPress = self.closeLongPress;
    cell.longPressDuration = self.longPressDuration;
    if ([self.dataSource respondsToSelector:@selector(customLongPressView)]) {
        [cell configImageWithImage:self.imageArray[indexPath.row]
                     longPressView:[self.dataSource customLongPressView]] ;
    }else{
        [cell configImageWithImage:self.imageArray[indexPath.row]
                     longPressView:nil] ;
    }
    cell.deleget = self;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:false];
//    // 隐藏和显示topView、bottomView
//    self.recordToRecommentLastHiddenStatus = !self.topView.hidden;
//    self.closeButton.hidden = YES;
//    self.image_title_label.hidden = YES;
//    [self hideTopAndBottomView:!self.topView.hidden];
//    [self setNeedsStatusBarAppearanceUpdate];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    CGSize size = CGSizeZero;
    return size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark - Action
//放大图片手势点击
-(void)gesTouchZoom:(UIGestureRecognizer*)ges{
    self.customImageViewTemp = (TXCustomImageView *)ges.view;
    NSInteger imageTag = self.customImageViewTemp.tag - imageViewTag;
    self.showImageindex = imageTag;
    [self showImageWithIndex:imageTag];
}

/**
 开始放大效果

 @param index index
 */
-(void)showImageWithIndex:(NSInteger )index{
    [self setaimageViewState:YES];
    //获取点击图片的相对父系坐标位置
    UIWindow *window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rectTemp=[self.customImageViewTemp convertRect: self.customImageViewTemp.bounds toView:window];
    //创建背景
    self.coverView.hidden = NO;
    self.coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1];
    //创建用来过渡动画的图片
    self.customimageAnimation  = [[TXCustomImageView alloc]init];
    self.customimageAnimation.image = self.customImageViewTemp.image;
    self.customimageAnimation.frame = rectTemp;
    self.customimageAnimation.userInteractionEnabled = YES;
    self.customimageAnimation.contentMode = UIViewContentModeScaleAspectFill;
    self.customimageAnimation.clipsToBounds = YES;
    [[self frontWindow] addSubview:self.customimageAnimation];
   //创建完成之后隐藏原图
    [self setImageHiddenWith:self.customImageViewTemp.tag - imageViewTag];
    //---动画显示
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect recttemp = [TXCustomImageSpecification calculateImageSpecification:self.customimageAnimation.image];
        self.customimageAnimation.frame = recttemp;
    }completion:^(BOOL finished){
        [[self frontWindow] addSubview:self.imageCollection];
        self.imageCollection.hidden = NO;
        [self.imageCollection reloadData];
        self.imageCollection.contentOffset = CGPointMake(SCREEN_WIDTH*(self.customImageViewTemp.tag - imageViewTag),0);
        self.customimageAnimation.hidden = YES;
        [self configBottomView];
        [self.delegate customViewBeginPreview];
        [self.delegate customViewSlideAtIndex:self.showImageindex];
    }];
}

/**
 开始缩小效果

 @param customImage TXCustomImage
 */
-(void)hideImageWithCustomImage:(TXCustomPhoto *)customImage
{
    [self.customDescriptionView removeFromSuperview];
    [self.customTopView removeFromSuperview];
    [self.customBottomView removeFromSuperview];
    [self.collectionPage removeFromSuperview];
    self.coverView.hidden = YES;
    self.imageCollection.hidden = YES;
    self.customimageAnimation.hidden = NO;
    
    TXCustomImageView *tempImageView;
    if (self.customViewContentType == CustomViewContentTypeDefault) {
        tempImageView = [self viewWithTag:self.showImageindex + imageViewTag];
        if (customImage.minImage) {
            self.customimageAnimation.image = customImage.minImage;
        }else if (customImage.maxImage){
            self.customimageAnimation.image = customImage.maxImage;
        }else{
            self.customimageAnimation.image = customImage.placeHolder;
        }
    }else{
        tempImageView = self.customImageViewTemp;
        self.customimageAnimation.image = self.customImageViewTemp.image;
    }
    UIWindow *window=[[[UIApplication sharedApplication] delegate] window];
    CGRect rectTemp=[tempImageView convertRect:tempImageView.bounds toView:window];
    if (rectTemp.origin.y<self.lessThanTop&&self.lessThanTop>0) {
        rectTemp.origin.x = SCREEN_WIDTH/2;
        rectTemp.origin.y = SCREEN_WIDTH/2;
        rectTemp.size.width = 0;
        rectTemp.size.height = 0;
    }
    if (rectTemp.origin.y>self.lessThanBottom&&self.lessThanBottom>0) {
        rectTemp.origin.x = SCREEN_WIDTH/2;
        rectTemp.origin.y = SCREEN_WIDTH/2;
        rectTemp.size.width = 0;
        rectTemp.size.height = 0;
    }
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.customimageAnimation.frame = rectTemp;
    } completion:^(BOOL finished) {
        self.customImageViewTemp.hidden = NO;
        [self setImageShow];
        [self.customimageAnimation removeFromSuperview];
        [self setaimageViewState:NO];
        [self.delegate customViewFinishPreview];
    }];
}

/**
 结束预览
 */
-(void)hideImage
{
    [self hideImageWithCustomImage:nil];
}

#pragma mark - TXCustomCollectionViewCellDeleget
-(void)tapImageGes:(TXCustomPhoto *)customImage{
    if (self.customViewContentType == CustomViewContentTypeDefault) {
        [self hideImageWithCustomImage:customImage];
    }else{
        if (self.customDescriptionView.alpha == 0) {
            [self hideBottomTopView:NO];
        }else{
            [self hideBottomTopView:YES];
        }
    }
}

-(void)slideRecognizerStateBegan:(BOOL)flag{
    self.imageCollection.scrollEnabled = flag;
}

-(void)slideImageGes:(CGFloat )moveDistance{
    self.coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1 - moveDistance / 500.0];
    self.collectionPage.alpha =(1 - moveDistance / 500.0);
    self.customDescriptionView.alpha =  moveDistance>0?0:1;
    self.customTopView.alpha = moveDistance>0?0:1;
    self.customBottomView.alpha = moveDistance>0?0:1;
}

-(void)slideOutImageGesAnimationEndWithRect:(CGRect)rect withImage:(TXCustomPhoto *)customImage{
    self.customimageAnimation.frame = rect;
    [self hideImageWithCustomImage:customImage];
    self.customDescriptionView.alpha = 1;
    self.customTopView.alpha = 1;
    self.customBottomView.alpha = 1;
}
-(void)slideOutImageGesReturnAnimationEnd{
    [UIView animateWithDuration:0.2 animations:^{
        self.coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:1];
        self.customDescriptionView.alpha = 1;
        self.customTopView.alpha = 1;
        self.customBottomView.alpha = 1;
    }];
}

#pragma mark - Privately owned
/**
 判断是否可以点击

 @param flag flag
 */
-(void)setaimageViewState:(BOOL )flag{
    self.animationClash = flag;
    for (TXCustomImageView *imageView in self.subviews) {
        if ([imageView isKindOfClass:[TXCustomImageView class]]) {
            imageView.userInteractionEnabled = !flag;
        }
    }
    self.collectionPage.alpha = 1;
}

/**
 隐藏指定图片

 @param index index
 */
-(void)setImageHiddenWith:(NSInteger )index{
    for (int i = 0; i<self.imageArray.count; i++) {
         TXCustomImageView *imageview  = [self viewWithTag:i+imageViewTag];
        imageview.hidden = NO;
    }
    TXCustomImageView *imageview  = [self viewWithTag:index+imageViewTag];
    imageview.hidden = YES;;
    
}

/**
 显示图片
 */
-(void)setImageShow{
    for (int i = 0; i<self.imageArray.count; i++) {
        TXCustomImageView *imageview  = [self viewWithTag:i+imageViewTag];
        imageview.hidden = NO;
    }
    self.coverView.hidden = YES;
    self.imageCollection.hidden = YES;
    [self.customimageAnimation removeFromSuperview];
    [self setaimageViewState:NO];
}


/**
 隐藏描述和拓展按钮

 @param flag BOOL
 */
-(void)hideBottomTopView:(BOOL )flag{
    [UIView animateWithDuration:0.1 animations:^{
        self.customDescriptionView.alpha = flag?0:1;
        self.customTopView.alpha = flag?0:1;
        self.customBottomView.alpha = flag?0:1;
    }];
}

#pragma mark - Lazy
- (UICollectionView *)imageCollection {
    if (!_imageCollection) {
        CGRect f = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _imageCollection = [[UICollectionView alloc] initWithFrame:f
                                              collectionViewLayout:flow];
        _imageCollection.userInteractionEnabled = true;
        _imageCollection.pagingEnabled = true;
        _imageCollection.dataSource = self;
        _imageCollection.delegate = self;
        _imageCollection.backgroundColor = [UIColor clearColor];
        [_imageCollection registerNib:[UINib nibWithNibName:@"TXCustomCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"TXCustomCollectionViewCell"];
    }
    return _imageCollection;
}
- (UIView  *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc]init];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [[self frontWindow] addSubview: _coverView];
    }
    return _coverView;
}

-(NSMutableArray *)imageRectArray
{
    if (!_imageRectArray) {
        _imageRectArray = [[NSMutableArray alloc]init];
    }
    return _imageRectArray;
}

-(UIPageControl *)collectionPage
{
    if (!_collectionPage) {
        _collectionPage = [[UIPageControl alloc]init];
        [_collectionPage sizeForNumberOfPages:0];
        [_collectionPage setNumberOfPages:self.imageArray.count];
        [_collectionPage setCurrentPage:0];
        _collectionPage.hidden = YES;
        [_collectionPage setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
        [_collectionPage setPageIndicatorTintColor:[UIColor grayColor]];
    }
    return _collectionPage;
}
-(TXCustomDescriptionView *)customDescriptionView
{
    if (!_customDescriptionView) {
        _customDescriptionView = [[TXCustomDescriptionView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-110, SCREEN_WIDTH, 60)];
    }
    return _customDescriptionView;
}

-(UIView *)customBottomView
{
    if (!_customBottomView) {
        //如果这里发生崩溃，请实现 TXCustomViewDataSource
        UIView *outView = [self.dataSource customBottomView];
        CGFloat x = 0;
        CGFloat y = SCREEN_HEIGHT - outView.frame.size.height;
        CGFloat w = SCREEN_WIDTH;
        CGFloat h = outView.frame.size.height;
        _customBottomView = [[UIView alloc]init];
        _customBottomView.frame = CGRectMake(x,y,w,h);
        [_customBottomView addSubview:outView];
    }
    return _customBottomView;
}

-(UIView *)customTopView
{
    if (!_customTopView) {
        //如果这里发生崩溃，请实现 TXCustomViewDataSource
        UIView *outView = [self.dataSource customTopView];
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat w = SCREEN_WIDTH;
        CGFloat h = outView.frame.size.height;
        _customTopView = [[UIView alloc]init];
        _customTopView.frame = CGRectMake(x,y,w,h);
        [_customTopView addSubview:outView];
    }
    return _customTopView;
}

- (UIWindow *)frontWindow {
#if !defined(SV_APP_EXTENSIONS)
    NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
    for (UIWindow *window in frontToBackWindows) {
        BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
        BOOL windowIsVisible = !window.hidden && window.alpha > 0;
        BOOL windowLevelSupported = (window.windowLevel >= UIWindowLevelNormal && window.windowLevel <= UIWindowLevelNormal);
        
        if(windowOnMainScreen && windowIsVisible && windowLevelSupported) {
            return window;
        }
    }
#endif
    return nil;
}

@end
