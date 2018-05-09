//
//  NSString+Additions.h
//  CqlivingCloud
//
//  Created by xinhualong on 16/5/9.
//  Copyright © 2016年 xinhualong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Additions)

#pragma mark - 加密
/**
 *  md5加密
 *
 *  @return 加密后的string
 */
- (NSString *)md5;

/**
 *  sha1加密
 *
 *  @return 加密后的string
 */
- (NSString *)sha1;

#pragma mark - Base64转换
/**
 *  将文本转换为base64编码
 *
 *  @return base64格式的NSString
 */
- (NSString *)base64EncodedString;

/**
 *  将Base64编码还原
 *
 *  @return 文本NSString
 */
- (NSString *)base64DecodedString;

#pragma mark - 判断合法性
/**
 *  判断链接是否包含在白名单里面
 *
 *  @return bool的判断结果
 */
- (BOOL)isIncludedInWhiteList;

/**
 *  判断字符串是否为空或者全是空字符串
 *
 *  @return bool的判断结果
 */
- (BOOL)isAllBlankCharacterOrNil;

#pragma mark - JS转换
/**
 json字符串转换成OC的数据结构
 
 @return OC的数据结构(包括NSDictionary、NSArray)
 */
- (id)jsonToObejct;

/**
 json字符串转字典
 
 @return 字典
 */
- (NSDictionary *)jsonToDictionary;


#pragma mark - 计算字符串宽度、高度
/**
 *  计算文字占用宽度
 *
 *  @param height 固定高度
 *  @param font   文字大小
 *
 *  @return 宽度
 */
- (CGFloat)calculateWidthWithHeight:(CGFloat)height
                               font:(UIFont *)font;

/**
 *  计算文字占用高度
 *
 *  @param width  固定宽度
 *  @param font   字体大小
 *
 *  @return 高度
 */
- (CGFloat)calculateHeightWithWidth:(CGFloat)width
                               font:(UIFont *)font;

/**
 *  计算文字占用高度（行间距）
 *
 *  @param width  固定宽度
 *  @param font   字体大小
 *  @param LineSpacing 行间距
 *
 *  @return 高度
 */
- (CGFloat)calculateHeightWithWidth:(CGFloat)width
                               font:(UIFont *)font
                        LineSpacing:(CGFloat)LineSpacing;

/**
 *  判断手机号
 *
 *  @return 是否合法
 */
- (BOOL)validateMobile;

/**
 字符串是为空（包括全空格）
 
 @return bool的判断结果
 */
- (BOOL)isEmpty;

/**
 *  根据字符的长度计算label的宽度
 *
 *  @return label的宽度
 */
- (CGFloat)labelTextCountWidth;

/**
 utf8编码，已经编码过的不在编码

 @return utf8编码的字符串
 */
- (NSString *)stringToUTF8StringEncoding;
@end
