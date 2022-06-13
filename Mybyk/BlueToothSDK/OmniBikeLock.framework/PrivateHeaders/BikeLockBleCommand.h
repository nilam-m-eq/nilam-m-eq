//
//  BikeLockBleCommand.h
//  SmartLock
//
//  Created by apple mini on 2021/1/28.
//  Copyright © 2021 Jean. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BikeLockBleCommand : NSObject

/*!
 * @property     cmdKey     Communication key
 */
@property (nonatomic,assign) UInt8 cmdKey;
/**
 ! 获取通信key 0x11
 */
- (NSData *)getCommunicationKey:(NSString *)deviceKey;

/**
 ! 开锁指令 0x21
 @param  userId   用户 ID
 @param  timestamp  开锁时间戳
 @param  outArea 越界标记  YES:继续上一个开锁记录开始计时； NO:计时从当前开始。 若无需设置，请设置为NO
 */
- (NSData *)sendUnlockWithUserId:(int)userId timestamp:(int)timestamp outArea:(BOOL)outArea;

/**
 ! 回复开锁 0x21
 */
- (NSData *)replyUnlock;

/**
 ! 收到关锁 0x22
 */
- (NSData *)replyLock;

/**
 ! 查询锁信息 0x31
 */
- (NSData *)obtainLockDetails;

/**
 ! 获取旧数据 0x51
 */
- (NSData *)obtainLastUseData;

/**
 ! 清除旧数据 0x52
 */
- (NSData *)clearLastData;

@end

NS_ASSUME_NONNULL_END
