//
//  LockEnumObject.h
//  OmniLockDemo
//
//  Created by apple on 2019/12/16.
//  Copyright © 2019 Jean. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Lock type
//typedef NS_ENUM(NSUInteger,LockType) {
//    LockTypeULock,
//    LockTypeCabinetLock,
//    LockTypeCableLock,
//    LockTypeKeyBox,
//    LockTypeFingerprint,
//    LockTypeParkLock,
//    LockTypeRemoteControl,
//    LockTypeEnvelopLock,
//    LockTypeOther
//};

#pragma mark - ULock battery
typedef NS_ENUM(UInt8,BatteryStatus) {
    BatteryStatusNormal = 0x00,
    BatteryStatusLow = 0x01
};

typedef NS_ENUM(NSInteger,StatusCmd) {
    StatusCmdModifyPsd,//modify unlock password
    StatusCmdUnlock,//unlock
    StatusCmdModifyKey,//Modify key
    StatusCmdModifyAdvName,//Modify broadcast name
    StatusCmdCheckCharge,//Querying the charging status
    StatusCmdResetRestart,//Reset restart
};

#pragma mark - Cable Lock
typedef NS_ENUM(UInt8, FirstUseCableLockCommand) {
    CableLockCommandUnlock                     = 0x80,
    CableLockCommandUnlockByApp                = 0x20,
    CableLockCommandUnlockByAppAndButton       = 0x10,
    CableLockCommandAntiTheftAutomatic         = 0x08,
    CableLockCommandAntiTheftManual            = 0x04,
    CableLockCommandLockedMode                 = 0x02,
    CableLockCommandUnlockedMode               = 0x01,
};

typedef NS_ENUM(UInt8, LastUseCableLockCommand){
    CableLockCommandMotorOn                    = 0x80,
    CableLockCommandMotorOff                   = 0x40,
    CableLockCommandLockSleep                  = 0x30,
    CableLockCommandAdvertisementOff           = 0x10,
    CableLockCommandLightTurnOn                = 0x08,
    CableLockCommandLightTurnOff               = 0x04,
    CableLockCommandRingTurnOn                 = 0x02,
    CableLockCommandRingTurnOff                = 0x01,
};

typedef NS_ENUM(UInt8, CableControlType) {
    CableControlTypeFirstCmd   = 0x05,
    CableControlTypeLastCmd    = 0x06,
};

#pragma mark - Cabinet Lock
typedef NS_ENUM(UInt8, CabinetLockKeyControl) {
    CabinetLockKeyControlModify = 0x01, //modify 8 bit key
    CabinetLockKeyControlDelete = 0x02, //delete 8 bit key
};

typedef NS_ENUM(UInt8, AutoUnlockState) {
    AutoUnlockStateWithOff      = 0x00,
    AutoUnlockStateWithOn       = 0x01,
};

#pragma mark - Key Box
typedef NS_ENUM(UInt8, KeyBoxKeyControl) {
    KeyBoxKeyControlModify      = 0x01, //modify 8 bit key
    KeyBoxKeyControlDelete      = 0x02, //delete 8 bit key
};

typedef NS_ENUM(UInt8, KBAlarmSettings) {
    KBAlarmSettingsWithOff      = 0x00,
    KBAlarmSettingsWithOn       = 0x01,
};

typedef NS_ENUM(UInt8, KBPasswordSettings) {
    KBPasswordSettingsWithInsert    = 0x01,//insert password
    KBPasswordSettingsWithInquiry   = 0x02,//inquiry password
    KBPasswordSettingsWithDelete    = 0x03,//delete password
    KBPasswordSettingsWithDeleteAll = 0x04,//delete all password
};

typedef NS_ENUM(UInt8, KeyBoxCommand) {
    kbObtainKey              = 0x01,//获取通信key | verify key
    kbSynchronizeDate        = 0x02,//同步时间戳  | synchronize timestamp
    kbAlarmSwitch            = 0x03,//报警开关 | alarm settings
    kbTakenAway              = 0x06,//钥匙被拿走 | the key taken away
    kbPutBack                = 0x07,//钥匙被放回 | the key put back
    kbCmdWrong               = 0x10,//指令错误 | command is wrong
    kbUnlock                 = 0x21,//开锁指令 | unlock
    kbLocked                 = 0x22,//收到关锁 | lock
    kbReadDetails            = 0x31,//查看锁信息 | read lock details
    kbModifyKey              = 0x33,//修改设备key | modify key
    kbLowPower               = 0x35,//低电量开锁 | low battery unlock
    kbUnlockRecord           = 0x51,//开锁使用记录 | unlock records
    kbClearRecord            = 0x52,//清除记录 | clear unlock history
    kbPasswordSettings       = 0x53,//操作密码 | password settings
    kbRandomPassword         = 0x55 //随机密码设置 | generate random password
};

#pragma mark - Fingerprint Lock
typedef NS_ENUM(UInt8, FingerprintLockCommand) {
    fpObtainKey              = 0x01,//获取通信key | verify key
    fpSynchronizeDate        = 0x02,//同步时间戳  | synchronize timestamp
    fpAlarmSwitch            = 0x03,//报警开关 | alarm settings
    fpCmdWrong               = 0x10,//指令错误 | command is wrong
    fpBleSettings            = 0x13,//蓝牙配置 | bluetooth settings
    fpUnlock                 = 0x21,//开锁指令 | unlock
    fpReadDetails            = 0x31,//查看锁信息 | read lock details
    fpModifyKey              = 0x33,//修改设备key | modify key
    fpUnlockRecord           = 0x51,//开锁使用记录 | unlock records
    fpClearRecord            = 0x52,//清除记录 | clear unlock history
    fpPasswordSettings       = 0x53,//预设密码 | password settings
    fpPasswordControl        = 0x54,//写入、删除密码 | Write or delete password
    fpUnlockPeriodSettings   = 0x55,//用户时间段设置 | Set user unlock period
    fpReadPasswordList       = 0x56,//密码列表读取 | read password lists
    fpUserNameSettings       = 0x57,//用户别名配置 | Configure user nickname
    fpAssociatedNumber       = 0x58,//关联手指编号 | Associated fingerprint number
};

typedef NS_ENUM(UInt8, FPPasswordSettings) {
    FPPasswordSettingsWithPassword       = 0x01,//password
    FPPasswordSettingsWithRFID           = 0x02,//RFID
    FPPasswordSettingsWithFingerprint    = 0x03,//fingerprint
    FPPasswordSettingsWithInterrupt      = 0x04 //interrupt  
};

typedef NS_ENUM(UInt8, FPPasswordControlType) {
    FPPasswordControlTypeWithDeleteAllUser     = 0x00,//delete all users
    FPPasswordControlTypeWithDeleteUser        = 0x01,//delete current user
    FPPasswordControlTypeWithDeleteSingle    = 0x02,//delete single
    FPPasswordControlTypeWithAddSingle       = 0x03,//add single
};

typedef NS_ENUM(UInt8, FPAlarmSettings) {
    FPAlarmSettingsWithOff      = 0x00,
    FPAlarmSettingsWithOn       = 0x01,
};

typedef NS_ENUM(UInt8, FingerprintKeyControl) {
    FingerprintKeyControlModify      = 0x01, //modify 8 bit key
    FingerprintKeyControlDelete      = 0x02, //delete 8 bit key
};

typedef NS_ENUM(UInt8, FingerprintConfigType) {
    FingerprintConfigTypeCheck       = 0x00,
    FingerprintConfigTypeAdd         = 0x01,
    FingerprintConfigTypeDelete      = 0x02,
};

#pragma mark - Parking Lock
typedef NS_ENUM(NSInteger, PLDeviceType) {
    PLDeviceTypeWithParkingLock,
    PLDeviceTypeWithRemoteControl
};

typedef NS_ENUM(UInt8, ParkingLockCommand) {
    parkObtainKey              = 0x01,//获取通信key | verify key
    parkObtainLockInfo         = 0x03,//获取车位锁本身的mac | Get parking lock for mac
    parkObtainRemoteInfo       = 0x04,//获取已配对遥控器信息 | Remote control information
    parkUnlock                 = 0x05,//不拦车 | unlock
    parkPairingRemote          = 0x06,//配对遥控器 | Pairing the remote control
    parkCmdWrong               = 0x10,//指令错误 | command is wrong
    parkSleep                  = 0x13,//车位锁休眠
    parkLock                   = 0x15,//拦车指令 | Lock
    parkObtainDetails          = 0x31,//查看锁信息 | Get lock information
    parkModifyKey              = 0x33,//修改设备key | Modify device key
    parkObtainLastData         = 0x51,//获取上一次使用数据 | Get last used data
    parkClearData              = 0x52,//清除车锁的使用数据 | Clear parking lock usage data
};

typedef NS_ENUM(UInt8, ParkingRemoteCommand) {
    remoteObtainKey            = 0x01,//获取通信key | verify key
    remoteObtainInfo           = 0x03,//获取遥控器本身mac地址 | Get remote control for mac
    remoteObtainLockInfo       = 0x04,//获取已配对的车位锁信息 | Get paired parking lock information
    remotePairingLock          = 0x06,//配对车位锁 | Pairing the parking lock
    remoteModelSettings        = 0x07,//设置遥控器控制模式 | Set the remote control mode
};

typedef NS_ENUM(UInt8,PLRemoteControlMode) {
    PLRemoteControlModeManual       = 0x01,//手动模式<当遥控器靠近车位锁，车位锁自动不拦车；远离车位锁，车位锁自动拦车。> | Manual mode <When the remote control is near the parking lock, the parking lock will not block the vehicle automatically; if it is far away from the parking lock, the parking lock will block the vehicle automatically. >
    PLRemoteControlModeAutomatic    = 0x02,//自动模式<手动模式：通过遥控器控制车位锁，拦车与不拦车。> | Automatic mode <Manual mode: Control the parking lock by remote control, blocking or not blocking. >
};

#pragma mark - Envelop Lock
typedef NS_ENUM(UInt8, EnvelopCommand) {
    evObtainKey               = 0x11,
    evUnlock                  = 0x21,
    evLocked                  = 0x22,
    evObtainDetails           = 0x31,
    evObtainLastData          = 0x51,
    evClearData               = 0x52,
};

#pragma mark - Scooter
typedef NS_ENUM(UInt8, ScooterCommand) {
    scoObtainKey             = 0x01,//获取通信key | verify key
    scoUnlock                = 0x05,//开锁指令 | unlock
    scoCmdWrong              = 0x10,//指令错误 | command is wrong
    scoLock                  = 0x15,//关锁指令 | lock
    scoObtainLockDetails     = 0x31,//查看锁信息 | Get lock information
    scoObtainLastData        = 0x51,//获取旧数据 | Get last used data
    scoClearData             = 0x52,//清除滑板车的使用数据 | Clear the scooter usage data
    scoObtainInfo            = 0x60,//获取滑板车信息，包括速度、距离、剩余里程等信息 | Get scooter information, including speed, distance, remaining mileage and other information
    scootSettings            = 0x61,//滑板车设置 | Scooter settings
    scoUnlockExternalDevice  = 0x81,//解锁外部设备 | Unlock external device
    scoRegistRfid            = 0x85,//注册Rfid卡 ｜ bind rfid card
    scoPowerSettings         = 0x91,//开机、关机<运输模式> | Power On or Power Off
};

typedef NS_ENUM(NSInteger,ScooterSettingsType) {
    ScooterSettingsTypeWithLightOpen,
    ScooterSettingsTypeWithLightClose,
    ScooterSettingsTypeWithSpeedModelLow,
    ScooterSettingsTypeWithSpeedModelMiddle,
    ScooterSettingsTypeWithSpeedModelHigh,
    ScooterSettingsTypeWithAcceleratorOpen,
    ScooterSettingsTypeWithAcceleratorClose,
    ScooterSettingsTypeWithTaillightOpen,
    ScooterSettingsTypeWithTaillightClose
};

typedef NS_ENUM(NSInteger,ExternalLockDeviceState) {
    //Battery Lock
    DeviceStateWithBatteryLockOpen = 0x01,
    DeviceStateWithBatteryLockClose = 0x11,
    
    //Wheel Lock
    DeviceStateWithWheelLockOpen = 0x02,
    DeviceStateWithWheelLockClose = 0x12,
    
    //Cable Lock
    DeviceStateWithCableLockOpen = 0x03,
    DeviceStateWithCableLockClose = 0x13,
    
    //Other
    DeviceStateCableLockOther
};

#pragma mark - Bike Lock
typedef NS_ENUM(UInt8, BikeLockCommand) {
    bikeObtainKey               = 0x11,
    bikeUnlock                  = 0x21,
    bikeLocked                  = 0x22,
    bikeObtainDetails           = 0x31,
    bikeObtainLastData          = 0x51,
    bikeClearData               = 0x52,
};

@interface LockEnumObject : NSObject

@end

NS_ASSUME_NONNULL_END
