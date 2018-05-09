//
//  TXCustomImageSpecification.m
//  Lottery
//
//  Created by 新华龙mac on 2017/9/27.
//  Copyright © 2017年 新华龙mac. All rights reserved.
//

#import "TXCustomImageSpecification.h"
#import "TXCustomTools.h"
@implementation TXCustomImageSpecification

+(CGRect )calculateImageSpecification:(UIImage *)image
{
    CGFloat width = CGImageGetWidth(image.CGImage);
    CGFloat hight = CGImageGetHeight(image.CGImage);
    
    if (width<=SCREEN_WIDTH&&hight<=SCREEN_WIDTH) {
        CGRect rect =CGRectMake(SCREEN_WIDTH/2-width/2, SCREEN_HEIGHT/2-hight/2, width, hight);
        return rect;
    }else if (width<=SCREEN_WIDTH&&hight>SCREEN_WIDTH)
    {
        CGRect rect =CGRectMake(SCREEN_WIDTH/2-(hight/SCREEN_WIDTH)/2, 0, width*(hight/SCREEN_HEIGHT), SCREEN_HEIGHT);
        return rect;
    }else if (width>SCREEN_WIDTH&&hight<=SCREEN_WIDTH)
    {
        CGRect rect =CGRectMake(0, SCREEN_HEIGHT/2-hight*(SCREEN_WIDTH/width)/2, SCREEN_WIDTH, hight*(SCREEN_WIDTH/width));
        return rect;
    }else if (width>SCREEN_WIDTH&&hight>SCREEN_WIDTH)
    {
        double sh = SCREEN_HEIGHT/hight;
        double sw = SCREEN_WIDTH/width;
        if (sh>sw) {
            CGRect rect = CGRectMake(SCREEN_WIDTH/2-(width*sw)/2, SCREEN_HEIGHT/2-(hight*sw)/2, width*sw, hight*sw);
            return rect;
        }else{
            CGRect rect = CGRectMake(SCREEN_WIDTH/2-(width*sh)/2, SCREEN_HEIGHT/2-(hight*sh)/2, width*sh, hight*sh);
            return rect;
        }
    }
    CGRect rect =CGRectMake(SCREEN_WIDTH/2-100, SCREEN_HEIGHT/2-100, 200, 200);
    return rect;
}


@end
