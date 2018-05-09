//
//  TXCustomTools.m
//  Lottery
//
//  Created by 新华龙mac on 2017/9/28.
//  Copyright © 2017年 新华龙mac. All rights reserved.
//

#import "TXCustomTools.h"
#import <Photos/Photos.h>
@implementation TXCustomTools
/**
 获取view的大小
 
 @param imageCount 图片的个数
 @param sets  自定义设置(自定义设置里面的imageSize的优先级高于函数带有的imageSize)
 @return view的高度
 */
+(CGSize )getCustomViewSizeWithImageCount:(NSInteger )imageCount
                                  withSetting:(TXCustomSizeSettings *)sets
{
    NSAssert(sets.throwNumber   >0, @"throwNumber不能为空，且大于0");
    NSAssert(sets.imageInterval >0 , @"imageInterval不能小于0");
    NSAssert(sets.defaultImageSize.width  >=0, @"defaultImage不能为空，且大于0");
    NSAssert(sets.defaultImageSize.height >=0, @"defaultImage不能为空，且大于0");
    
    NSInteger indexThrowNumber = imageCount<=sets.throwNumber?imageCount:sets.throwNumber;
    
    CGSize sizeResult;
    CGSize onlyOneImageSize   = sets.onlyOneImageSize;
    CGSize onlyTwoImageSize   = sets.onlyTwoImageSize;
    CGSize onlyThreeImageSize = sets.onlyThreeImageSize;
    CGSize frontRowImageSize  = sets.frontRowImageSize;
    if (imageCount == 1 && onlyOneImageSize.width>0&&onlyOneImageSize.height>0) {
        sizeResult = onlyOneImageSize;
        return sizeResult;
    }else if (imageCount == 2 && onlyTwoImageSize.width>0&&onlyTwoImageSize.height>0)
    {
        CGFloat width = onlyTwoImageSize.width;
        CGFloat hight = onlyTwoImageSize.height;
        sizeResult.width = width*indexThrowNumber+(indexThrowNumber-1)*sets.imageInterval;
        NSInteger index;
        index = imageCount/sets.throwNumber;
        if (imageCount%sets.throwNumber>0) {
            index += 1;
        }
        sizeResult.height = hight*index+(index-1)*sets.imageInterval;
        return sizeResult;
        
    }else if (imageCount == 3 && onlyThreeImageSize.width>0&&onlyThreeImageSize.height>0)
    {
        CGFloat width = onlyThreeImageSize.width;
        CGFloat hight = onlyThreeImageSize.height;
        sizeResult.width = width*indexThrowNumber+(indexThrowNumber-1)*sets.imageInterval;
        NSInteger index;
        index = imageCount/sets.throwNumber;
        if (imageCount%sets.throwNumber>0) {
            index += 1;
        }
        sizeResult.height = hight*index+(index-1)*sets.imageInterval;
        return sizeResult;
        
    }else if (imageCount == sets.throwNumber&& frontRowImageSize.width>0&&frontRowImageSize.height>0)
    {
        CGFloat width = frontRowImageSize.width;
        CGFloat hight = frontRowImageSize.height;
        sizeResult.width = width*indexThrowNumber+(indexThrowNumber-1)*sets.imageInterval;
        NSInteger index;
        index = imageCount/sets.throwNumber;
        if (imageCount%sets.throwNumber>0) {
            index += 1;
        }
        sizeResult.height = hight*index+(index-1)*sets.imageInterval;
        return sizeResult;
    }

    CGFloat width = sets.defaultImageSize.width;
    CGFloat hight = sets.defaultImageSize.height;
    sizeResult.width = width*indexThrowNumber+(indexThrowNumber-1)*sets.imageInterval;
    NSInteger index;
    index = imageCount/sets.throwNumber;
    if (imageCount%sets.throwNumber>0) {
        index += 1;
    }    sizeResult.height = hight*index+(index-1)*sets.imageInterval;
    return sizeResult;
}

+(void)saveImageToPhotoAlbumWithCustomImage:(TXCustomPhoto *)customImage
                         andOperationStatus:(OperationStatusBlock)status{
    if (customImage.maxImage) {
        [self loadImageFinished:customImage.maxImage andOperationStatus:status];
    }else if (customImage.minImage){
        [self loadImageFinished:customImage.minImage andOperationStatus:status];
    }else{
        NSLog(@"图片加载中，请稍后");
    }
}

+(void)loadImageFinished:(UIImage *)image andOperationStatus:(OperationStatusBlock)status
{
    NSMutableArray *imageIds = [NSMutableArray array];
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        [imageIds addObject:req.placeholderForCreatedAsset.localIdentifier];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        status(success);
    }];
}

@end
