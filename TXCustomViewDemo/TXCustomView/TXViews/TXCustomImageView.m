//
//  TXCustomImageView.m
//  Lottery
//
//  Created by 新华龙mac on 2017/9/27.
//  Copyright © 2017年 新华龙mac. All rights reserved.
//

#import "TXCustomImageView.h"
#import "UIImageView+WebCache.h"
//#import "CMSVideoProgressView.h"

@interface TXCustomImageView()

@end

@implementation TXCustomImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)loadMinImage:(TXCustomPhoto *)TXImage andLoadImageStatusBlock:(LoadImageStatusBlock )LoadImageStatusBlock{
    if (TXImage.minImage) {
        self.image = TXImage.minImage;
        LoadImageStatusBlock(YES,TXImage.minImage,1);
    }else{
        [self sd_setImageWithPreviousCachedImageWithURL:TXImage.minUrl placeholderImage:TXImage.placeHolder options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            CGFloat index = receivedSize/expectedSize;
            LoadImageStatusBlock(NO,nil,index);
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image== nil||!image) {
                LoadImageStatusBlock(NO,nil,0);
            }else{
                LoadImageStatusBlock(YES,image,1);
            }
        }];
    }

}

/**
 加载大图
 
 @param TXImage TXCustomImage
 @param LoadImageStatusBlock LoadImageStatusBlock description
 */
-(void)loadMaxImage:(TXCustomPhoto *)TXImage andLoadImageStatusBlock:(LoadImageStatusBlock )LoadImageStatusBlock{
    if (TXImage.maxImage) {
        self.image = TXImage.maxImage;
        LoadImageStatusBlock(YES,TXImage.maxImage,1);
    }else{
        __weak typeof(self) weakSelf = self;
//        //要让self的fram大于0.
//        if (self.frame.size.width>0) {
//            [self addSubview:self.progressView];
//             self.progressView.progressValue = 0;
//        }
        [self sd_setImageWithPreviousCachedImageWithURL:TXImage.maxUrl placeholderImage:TXImage.placeHolder options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            float index = (float)receivedSize/(float)expectedSize;
            LoadImageStatusBlock(NO,nil,index);
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image== nil||!image) {
                LoadImageStatusBlock(NO,nil,0);
            }else{
                LoadImageStatusBlock(YES,image,1);
            }
//            [weakSelf.progressView removeFromSuperview];
        }];
    }
}

//#pragma  mark - Lazy
//-(CMSVideoProgressView *)progressView
//{
//    if (!_progressView) {
//        _progressView = [CMSVideoProgressView viewWithFrame:CGRectMake(self.frame.size.width/2-25/2, self.frame.size.height/2-25/2,25, 25) circlesSize:CGRectMake(20, 20, 25, 25)];
//        _progressView.progressValue = 0;
//    }
//    return _progressView;
//}
///**
// 加载图片（哪一种有内容加载哪一种，默认大图）
// 
// @param TXImage TXCustomImage
// @param LoadImageStatusBlock LoadImageStatusBlock description
// */
//-(void)loadImage:(TXCustomImage *)TXImage andLoadImageStatusBlock:(LoadImageStatusBlock )LoadImageStatusBlock{
//    if (TXImage.maxImage) {
//        self.image = TXImage.maxImage;
//        LoadImageStatusBlock(YES,TXImage.maxImage,1);
//    }else if (TXImage.mia)
//}

@end
