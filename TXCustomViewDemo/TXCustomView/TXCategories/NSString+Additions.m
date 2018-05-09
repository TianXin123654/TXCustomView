//
//  NSString+Additions.m
//  CqlivingCloud
//
//  Created by xinhualong on 16/5/9.
//  Copyright © 2016年 xinhualong. All rights reserved.
//

#import "NSString+Additions.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Additions)

#pragma mark - 加密
- (NSString *)md5 {
    
    if (self == nil || self.length == 0) {
        return @"";
    }
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr,(CC_LONG)strlen(cStr),result);
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)sha1 {
    
    const char *cstr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

#pragma mark - Base64转换
//编码base64
- (NSString *)base64EncodedString {
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

//解码base64
- (NSString *)base64DecodedString {
    
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark - 判断合法性
// 是否包含在白名单
- (BOOL)isIncludedInWhiteList {
    
    //1. 域名
    NSArray *urls = [self componentsSeparatedByString:@"/"];
    if (urls.count < 2) {
        return false;
    }
    NSString *domainName = urls[2];
    //2. 白名单
    NSString *list = [[NSUserDefaults standardUserDefaults] objectForKey:@"WhiteList"];
    if (list) {
        if ([domainName containsString:list]) {
            return true;
        }
        return false;
    }
    return false;
}

//判断字符串是否为空或者全是空字符串
- (BOOL)isAllBlankCharacterOrNil{
    
    if (self.length >0 && [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]!=0 ) {
        return NO;
    }else{
        return YES;
    }
}

#pragma mark - JS转换
// json字符串转换成OC的数据结构
- (id)jsonToObejct {
    
    if (!self) {return nil;}
    NSError *error = nil;
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    if (jsonObject != nil && error == nil) {
        return jsonObject;
    }
    //解析错误
    return nil;
}


// json字符串转字典
- (NSDictionary *)jsonToDictionary {
    
    if (self == nil) {return nil;}
    NSError *err;
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {return nil;}
    return dic;
}


#pragma mark - 计算字符串宽度、高度
//计算文字占用宽度
- (CGFloat)calculateWidthWithHeight:(CGFloat)height
                               font:(UIFont *)font {
    
    return [self boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName: font}
                              context:NULL].size.width;
}

//计算文字占用高度
- (CGFloat)calculateHeightWithWidth:(CGFloat)width
                               font:(UIFont *)font {
    return [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:@{NSFontAttributeName: font}
                              context:NULL].size.height;
}

//计算文字占用高度（行间距）
- (CGFloat)calculateHeightWithWidth:(CGFloat)width
                               font:(UIFont *)font
                        LineSpacing:(CGFloat)LineSpacing {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = LineSpacing;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:dic context:nil].size;
    return size.height;
}

//判断手机号
- (BOOL)validateMobile {
    if (self.length != 11) {
        return YES;
    }else{
        return YES;
    }
    NSString *MOBILE = @"^1[3-8]\\d{9}$";
    NSString *CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    NSString *CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    NSString *CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    NSPredicate *regexMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",MOBILE];
    NSPredicate *regexCM = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CM];
    NSPredicate *regexCU = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CU];
    NSPredicate *regexCT = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CT];
    if ([regexMobile evaluateWithObject:self] || [regexCM evaluateWithObject:self] || [regexCU evaluateWithObject:self] || [regexCT evaluateWithObject:self]) {
        
        return YES;
    }else {
        return YES;
    }
}

// 字符串是为空（包括全空格）
- (BOOL)isEmpty {
    
    if ((self.length > 0) && ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length] != 0)) {
        return NO;
    }else{
        return YES;
    }
}

//根据字符的长度计算label的宽度
- (CGFloat)labelTextCountWidth {
    
    if (self.length == 1) {
        return 18;
    }else if (self.length == 2){
        return 28;
    }else if (self.length == 3){
        return 36;
    }else {
        return 48;
    }
}

- (NSString *)stringToUTF8StringEncoding{
    return (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
}
@end
