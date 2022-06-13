//
//  InstructionData.h
//  park_lock
//
//  Created by apple on 2018/1/11.
//  Copyright © 2018年 jean. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InstructionData : NSObject

unsigned char CRC8_Table(unsigned char *p, char counter);

/**
 * 蓝牙指令统一调用
 * @param  byte : 需要发送的byte数组
 * @param  len  : byte数组长度
 */
+ (NSData *)crc8_sendInstructionData:(Byte *)byte Len:(int)len;

+ (NSData *)crc16_sendInstructionData:(NSData *)sendData;

+ (BOOL)re_calcCRCWithByte:(Byte *)data withLen:(int)len;

/**
 * CRC16校验
 */
+ (int)calcCRCWithData:(NSData *)data offset:(int)offset preval:(int)preval;
@end
