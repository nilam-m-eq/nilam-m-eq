//
//  EncryptionDecodeTool.h
//  OmniLockDemo
//
//  Created by apple on 2019/12/12.
//  Copyright © 2019 Jean. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EncryptionDecodeTool : NSObject

/**
 * 获取随机整数 范围在[from,to），包括from，包括to
 */
+ (int)getRandomNumber:(int)from to:(int)to;

/**
 * 截取bytes数组中的某一段数据
 */
+ (NSData *)interceptFrom:(int)from lenth:(int)lenth data:(NSData *)data;

/**
 * byte数组异或随机数
 */
+ (Byte *)byteDecryptionBytes:(Byte[_Nonnull])originalByte randomNum:(Byte)randomNum from:(int)from  to:(int)to;

/**
 * @discussion 转换data中的一部分bytes为字符串
 * @param      range 转换的范围
 */
+ (NSString *)getChangeStringWithBytes:(Byte [_Nullable])dataBytes withLen:(int)len wihtRange:(NSRange)range;

/**
 * byte数组转十进制
 */
+ (NSString *)byteConversionHexWithBytes:(Byte[_Nonnull])bytes withlen:(int)len;

/**
 * 随机数变种
 */
+ (unsigned short)getShortRandowNUm:(int)num;

/**
 * 十进制转二进制
 */
+ (NSString *)toBinarySystemWithDecimalSystem:(NSInteger)decimal;

/**
 * 二进制转十进制
 */
+ (NSInteger)convertDecimalSystemFromBinarySystem:(NSString *)binary;

/**
 * byte 转二进制字符串
 */
+ (NSString *)getCommandBitString:(UInt8)value;

/**
 * 十六进制字符串转data<取byte>
 */
+ (NSData *)dataFromHexString:(NSString *)hexStr;

/**
 * data转十六进制
 */
+ (NSString *)hexStringWithData:(NSData *)data;

/**
 * 生成随机密码
 */
+ (NSString *)generateRandomCodeWithDuration:(long)duration psdLen:(int)len;

/**
 * 求负数的补码
 */
+ (int)calcuRssiWithValue:(int)value;

@end

NS_ASSUME_NONNULL_END
