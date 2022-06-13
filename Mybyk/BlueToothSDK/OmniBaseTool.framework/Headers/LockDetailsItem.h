//
//  LockDetailsItem.h
//  OmniLockDemo
//
//  Created by apple on 2019/12/16.
//  Copyright © 2019 Jean. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LockEnumObject.h"
#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface LockDetailsItem : NSObject

@property (nonatomic, strong) NSString *mac;

@property (nonatomic, strong) NSNumber *RSSI;

@property (nonatomic, strong) NSString *deviceName;

@property (nonatomic, assign) float distance;

//@property (nonatomic, assign) LockType type;

@property (nonatomic, retain) CBPeripheral *peripheral;

//default is NO
@property (nonatomic,assign,readwrite) BOOL isConnected;


// When the lock type is ULock will be return, other is nil
@property (nonatomic, strong) NSString *version;

@property (nonatomic, assign) BatteryStatus powerStatus;

/* personal lock */
@property (nonatomic,strong) NSString *deviceType;
//working voltage (voltage/10 = V)
@property (nonatomic,assign) int voltage;
//0:OFF   1:ON
@property (nonatomic,assign) int lockStatus;
//Battery percentage
@property (nonatomic,assign) int powerPercent;

@end


#pragma mark - tpye: ULock
@interface ObtainKeyModel: NSObject

@property (nonatomic,strong) NSData *tokenData;

@property (nonatomic,assign) int platformType;

@property (nonatomic,strong) NSString *version;

@property (nonatomic,assign) int deviceType;

+ (instancetype)initWithToken:(NSData *)token platform:(int)pType version:(NSString *)version deviceType:(int)dType;

@end

@interface StatusModel : NSObject

@property (nonatomic,assign) int status;

@property (nonatomic,assign) StatusCmd cmd;

+ (instancetype)initWithStatus:(int)status cmd:(StatusCmd)cmd;

@end

@interface FingerprintStatusModel: NSObject

@property (nonatomic,assign) int pages;//all pages

@property (nonatomic,assign) int curPage;//current page

@property (nonatomic,strong) NSData *data;

+ (instancetype)initWithPages:(int)all curPage:(int)cur data:(NSData *)data;

@end

@interface FingerprintStatusDataVo : NSObject

//lock status 0:off | 1:on
@property (nonatomic,assign) int lockStatus;

//fingerprint count
@property (nonatomic,assign) int count;

//power status 0:normal | 1:low power
@property (nonatomic,assign) int batteryStatus;

//work status 0:normal | 1:upgrading | 2:power off
@property (nonatomic,assign) int workStatus;

//Version information length
@property (nonatomic,assign) int versionLen;

//version information
@property (nonatomic,strong) NSString *version;

+ (instancetype)initWithData:(NSData *)data;

@end


#pragma mark - type: Cable Lock
@interface CableLockModel : NSObject

// 0: off;  1: on
@property (nonatomic,assign) int ringStatus;

// 0: off;  1: on
@property (nonatomic,assign) int motorStatus;

// 0: turn off;  1: turn on
@property (nonatomic,assign) int lightStatus;

// 0: app;  1: app or button
@property (nonatomic,assign) int unlockMode;

// 0: manual  1: automatic
@property (nonatomic,assign) int antiTheftMode;

// 0: open; 1: close
@property (nonatomic,assign) int lockStatus;

// electricity percent
@property (nonatomic,assign) int powerPercent;

@end

#pragma mark - tpye: Personal Lock (Cable Lock V2)
@interface PerSonalVerifiedModel : NSObject
//explain
@property (nonatomic,strong) NSString *message;

// Yes: allow;  No: refuse
@property (nonatomic,assign) BOOL isSuccess;

@property (nonatomic,assign) UInt8 cmdKey;

@end

@interface PersonalUnlockModel : NSObject

//explain
@property (nonatomic,strong) NSString *message;

//unlock timestamp
@property (nonatomic,strong) NSString *timeStamp;

//result
@property (nonatomic,assign) BOOL isSuccess;

@end

@interface PersonalCMDModel : NSObject

//explain
@property (nonatomic,strong) NSString *message;

@property (nonatomic,assign) int state;

@end

@interface PersonalLockedModel : NSObject

//explain
@property (nonatomic,strong) NSString *message;

//locked timestamp
@property (nonatomic,strong) NSString *timeStamp;

//use time
@property (nonatomic,strong) NSString *useTime;

//result
@property (nonatomic,assign) BOOL isSuccess;

@end

@interface PersonalPasswordSettingsModel : NSObject

//result
@property (nonatomic,assign) BOOL isSuccess;

@end

@interface PersonalLockDetails : NSObject

@property (nonatomic,strong) NSString *voltage;

@property (nonatomic,assign) int lockState;

#warning version = mVersion.lVersion.versionCount
//main version
@property (nonatomic,assign) UInt8 mVersion;

//minor version
@property (nonatomic,assign) UInt8 lVersion;

//number of version
@property (nonatomic,assign) UInt8 versionCount;

@end

@interface PersonalOldDataModel : NSObject

@property (nonatomic,strong) NSString *timestamp;

//mins
@property (nonatomic,assign) int useTime;

//user Id
@property (nonatomic,assign) int userId;

@end

@interface PersonalClearDataModel : NSObject

@property (nonatomic,assign) BOOL isSuccess;

@end

@interface PersonalLockSettingsModel : NSObject

//1:OFF 2:ON
@property (nonatomic,assign) int bleUnlockStatus;

//1:OFF 2:ON
@property (nonatomic,assign) int buttonUnlockStatus;

//1:OFF 2:ON
@property (nonatomic,assign) int rfidUnlockStatus;

@end

@interface RegisterRFIDModel: NSObject

//0:start;  1:success
@property (nonatomic,assign) int status;

@property (nonatomic,strong) NSString *cardNumber;

@end

@interface PersonalWorkingModel : NSObject

@property (nonatomic,assign) BOOL isSuccess;

@end

#pragma mark - type: Cabinet Lock
@interface CabinetVerifiedModel: NSObject

//explain
@property (nonatomic,strong) NSString *message;

// Yes: allow;  No: refuse
@property (nonatomic,assign) BOOL isSuccess;

@property (nonatomic,assign) UInt8 cmdKey;

@end

@interface CabinetCMDModel : NSObject

//explain
@property (nonatomic,strong) NSString *message;

@property (nonatomic,assign) int state;

@end

@interface CabinetUnlockModel : NSObject

//explain
@property (nonatomic,strong) NSString *message;

//unlock timestamp
@property (nonatomic,strong) NSString *timeStamp;

//result
@property (nonatomic,assign) BOOL isSuccess;

@end

@interface CabinetLockedModel : NSObject

//explain
@property (nonatomic,strong) NSString *message;

//locked timestamp
@property (nonatomic,strong) NSString *timeStamp;

//result
@property (nonatomic,assign) BOOL isSuccess;

@end

@interface CabinetLockDetails : NSObject

@property (nonatomic,strong) NSString *voltage;

@property (nonatomic,assign) int lockState;
//1:ON, 0:OFF
@property (nonatomic,assign) BOOL lowPowerUnlock;

#warning version = mVersion.lVersion.versionCount
//main version
@property (nonatomic,assign) UInt8 mVersion;

//minor version
@property (nonatomic,assign) UInt8 lVersion;

//number of version
@property (nonatomic,assign) UInt8 versionCount;

@end

@interface CabinetModifyKeyModel : NSObject

//explain
@property (nonatomic,strong) NSString *message;

//status  0:fail; 1:success; 2:delete
@property (nonatomic,assign) int status;

@end

@interface CabinetLowPowerModel : NSObject

//0:off; 1:on
@property (nonatomic,assign) int status;

@end


#pragma mark - type: Key Box
@interface KeyBoxVerifiedModel: NSObject

//explain
@property (nonatomic,strong) NSString *message;

// Yes: allow;  No: refuse
@property (nonatomic,assign) BOOL isSuccess;

@property (nonatomic,assign) UInt8 cmdKey;

@end

@interface KeyBoxCMDModel : NSObject

//explain
@property (nonatomic,strong) NSString *message;

@property (nonatomic,assign) int state;

@end

@interface KeyBoxResultModel : NSObject
/*!
 * @property                isSuccess    result
 *
 * @discussion              Contains: 0x02 | 0x03 | 0x52 | 0x55
 */
@property (nonatomic,assign) BOOL isSuccess;

@property (nonatomic,assign) KeyBoxCommand cmd;

@end

@interface KeyBoxKeysStatus : NSObject
// 0x06 | 0x07
@property (nonatomic,assign) UInt8 type;
//1: have key  0:no key
@property (nonatomic,assign) int key_1;

//1: have key  0:no key
@property (nonatomic,assign) int key_2;

//1: have key  0:no key
@property (nonatomic,assign) int key_3;

@end

@interface KeyBoxUnlockModel : NSObject

//1:sucess ;  2:fail
@property (nonatomic,assign) int status;

//unlock timestamp
@property (nonatomic,strong) NSString *timestamp;

@end

@interface KeyBoxLockedModel : NSObject

//1:sucess ;  2:fail
@property (nonatomic,assign) int status;

//1: have key  0:no key
@property (nonatomic,assign) int key_1;

//1: have key  0:no key
@property (nonatomic,assign) int key_2;

//1: have key  0:no key
@property (nonatomic,assign) int key_3;

//unlock timestamp
@property (nonatomic,strong) NSString *timestamp;

@end

@interface KeyBoxLockDetails : NSObject

@property (nonatomic,strong) NSString *voltage;
//1:ON; 0:OFF
@property (nonatomic,assign) int lockStatus;
//1:YES; 0:NO
@property (nonatomic,assign) BOOL haveOldData;
//1:have key  0:no key
@property (nonatomic,assign) int key_1;
//1:have key  0:no key
@property (nonatomic,assign) int key_2;
//1:have key  0:no key
@property (nonatomic,assign) int key_3;
//1:ON; 0:OFF
@property (nonatomic,assign) BOOL alarmStatus;
//1:Max(count = 10),limit reached; 0:allow add
@property (nonatomic,assign) BOOL passwordStatus;

// key box current timestamp
@property (nonatomic,strong) NSString *timestamp;

#warning version = mVersion.lVersion.versionCount
//main version
@property (nonatomic,assign) UInt8 mVersion;
//minor version
@property (nonatomic,assign) UInt8 lVersion;
//number of version
@property (nonatomic,assign) UInt8 versionCount;

@end

@interface keyBoxModifyKeyModel : NSObject

//explain
@property (nonatomic,strong) NSString *message;

//status  0:fail; 1:success; 2:delete
@property (nonatomic,assign) int status;

@end

@interface KeyBoxLowPowerModel : NSObject

//0:off; 1:on
@property (nonatomic,assign) int status;

@end

@interface KeyBoxUnlockRecord : NSObject

@property (nonatomic,assign) UInt8 data_6;
@property (nonatomic,assign) UInt8 data_7;

//record No.
@property (nonatomic,strong) NSString *number;

//unlock timestamp
@property (nonatomic,strong) NSString *timestamp;

//unlock cost time
@property (nonatomic,assign) int duration;

//use password
@property (nonatomic,strong) NSString *password;

//1: have key  0:no key
@property (nonatomic,assign) int key_1;

//1: have key  0:no key
@property (nonatomic,assign) int key_2;

//1: have key  0:no key
@property (nonatomic,assign) int key_3;

@end

@interface KeyBoxPasswordSettingsModel : NSObject

//result
@property (nonatomic,assign) BOOL isSuccess;

//all password count
@property (nonatomic,assign) int count;

//Operation type
@property (nonatomic,assign) KBPasswordSettings type;

@end

#pragma mark - Fingerprint Lock
@interface FingerprintVerifiedModel: NSObject

//explain
@property (nonatomic,strong) NSString *message;

// Yes: allow;  No: refuse
@property (nonatomic,assign) BOOL isSuccess;

@property (nonatomic,assign) UInt8 cmdKey;

@end

@interface FingerprintResultModel : NSObject
/*!
 * @property                isSuccess    result
 *
 * @discussion              Contains: 0x02 | 0x03 | 0x52 | 0x55
 */
@property (nonatomic,assign) BOOL isSuccess;

@property (nonatomic,assign) FingerprintLockCommand cmd;

@end

@interface FingerprintCMDModel : NSObject

//explain
@property (nonatomic,strong) NSString *message;

@property (nonatomic,assign) int state;

@end

@interface FingerprintUnlockModel : NSObject

//1:sucess ;  2:fail
@property (nonatomic,assign) int status;

//unlock timestamp
@property (nonatomic,strong) NSString *timestamp;

@end

@interface FingerprintLockDetails : NSObject

@property (nonatomic,strong) NSString *voltage;
//1:ON; 0:OFF
@property (nonatomic,assign) int lockStatus;
//1:YES; 0:NO
@property (nonatomic,assign) BOOL haveOldData;
//1:have key  0:no key
@property (nonatomic,assign) int key_1;
//1:have key  0:no key
@property (nonatomic,assign) int key_2;
//1:have key  0:no key
@property (nonatomic,assign) int key_3;
//1:ON; 0:OFF
@property (nonatomic,assign) BOOL alarmStatus;
//1:Max(count = 10),limit reached; 0:allow add
@property (nonatomic,assign) BOOL passwordStatus;

// key box current timestamp
@property (nonatomic,strong) NSString *timestamp;

#warning version = mVersion.lVersion.versionCount
//main version
@property (nonatomic,assign) UInt8 mVersion;
//minor version
@property (nonatomic,assign) UInt8 lVersion;
//number of version
@property (nonatomic,assign) UInt8 versionCount;

@end

@interface FingerprintModifyKeyModel : NSObject

//explain
@property (nonatomic,strong) NSString *message;

//status  0:fail; 1:success; 2:delete
@property (nonatomic,assign) int status;

@end

@interface FingerprintUnlockRecord : NSObject

@property (nonatomic,assign) UInt8 data_6;
@property (nonatomic,assign) UInt8 data_7;

//user No. 0:temporary, [1-100]: user
@property (nonatomic,assign) UInt8 number;

@property (nonatomic, strong) NSString *userName;

//unlock type 1=password  2=rfid  3=fingerprint  4=temporary password  5=app
@property (nonatomic,assign) UInt8 type;

//unlock timestamp
@property (nonatomic,strong) NSString *timestamp;

//unlock password
//@property (nonatomic,strong) NSString *password;

@end

@interface FingerprintPasswordSettingsModel : NSObject

//result
@property (nonatomic,assign) BOOL isSuccess;

//user No.
@property (nonatomic,assign) int userNumber;

//Operation type
@property (nonatomic,assign) FPPasswordSettings type;

//password | RFID | fingerprint No.
@property (nonatomic,strong) NSString *target;

@end

@interface FingerprintControlPasswordModel : NSObject

@property (nonatomic,assign) FPPasswordControlType controlType;

// user No.
@property (nonatomic,assign) UInt8 number;

// password | RFID | fingerprint
@property (nonatomic,assign) FPPasswordSettings way;

//result
@property (nonatomic,assign) BOOL isSuccess;

@end

@interface FingerprintPwdInfoModel : NSObject

@property (nonatomic,assign) BOOL isSuccess;

//user number
@property (nonatomic,assign) UInt8 userNo;

//password
@property (nonatomic,strong) NSString *password;

//RFID
@property (nonatomic,strong) NSString *rfid;

//finger 1
@property (nonatomic,assign) UInt8 finger1;

//finger 2
@property (nonatomic,assign) UInt8 finger2;

//finger 3
@property (nonatomic,assign) UInt8 finger3;

//finger 4
@property (nonatomic,assign) UInt8 finger4;

@end

@interface FingerprintUnlockPeriodModel : NSObject

@property (nonatomic,assign) int userId;

@property (nonatomic,assign) BOOL isSuccess;

@property (nonatomic,assign) int startTime;

@property (nonatomic,assign) int endTime;

@property (nonatomic,assign) int week;

@property (nonatomic,assign) int group;

@end

@interface FingerprintNameConfigModel : NSObject

@property (nonatomic,assign) int userId;

@property (nonatomic,assign) BOOL isSuccess;

@property (nonatomic,strong) NSString *nickname;

@property (nonatomic,assign) int curIndex;

@property (nonatomic,assign) int count;

@end

@interface FingerprintNoAssociatedModel : NSObject

@property (nonatomic,assign) int userId;

@property (nonatomic,assign) BOOL isSuccess;

@property (nonatomic,strong) NSArray *numberArr;

@end

#pragma mark - Parking Lock
@interface ParkingLockVerifiedModel: NSObject

//explain
@property (nonatomic,strong) NSString *message;

// Yes: allow;  No: refuse
@property (nonatomic,assign) BOOL isSuccess;

@property (nonatomic,assign) UInt8 cmdKey;

@end

@interface ParkingLockCMDModel : NSObject

//explain
@property (nonatomic,strong) NSString *message;

@property (nonatomic,assign) int state;

@end

@interface ParkingLockUnlockModel : NSObject

//1:sucess ;  2:fail
@property (nonatomic,assign) int status;

//unlock timestamp
@property (nonatomic,strong) NSString *timestamp;

@end

@interface ParkingDeviceInfo : NSObject
@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSString *mac;
@property (nonatomic,assign) int status;//1:success 0:fail
@end

@interface ParkingRemoteInfo : NSObject
@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSString *mac;
@property (nonatomic,assign) int status;//1:success 0:fail
@end

@interface ParkingLockPairRemoteModel : NSObject
@property (nonatomic,strong) NSString *message;
@property (nonatomic,assign) int status;//1:success 0:Start pairing
@end

@interface ParkingDeviceLockModel : NSObject
@property (nonatomic,assign) int status;// 0:Start locking,1:Locked successfully,2: Locked timeout
@property (nonatomic,strong) NSString *timestamp;
@property (nonatomic,assign) int useTime;
@end

@interface ParkingLockDetailsModel : NSObject
@property (nonatomic,strong) NSString *voltage;
@property (nonatomic,strong) NSString *version;
@property (nonatomic,assign) int lockState;//0:unlock 1:lock
@property (nonatomic,assign) int oldData;//0:NO 1:Yes
@end

@interface ParkingModifyKeyModel : NSObject
@property (nonatomic,assign) BOOL isSuccess;
@end

@interface ParkingLockOldDataModel : NSObject
@property (nonatomic,strong) NSString *timestamp;
@property (nonatomic,strong) NSString *useTime;
@property (nonatomic,strong) NSString *userId;
@end

@interface ParkingLockClearDataModel : NSObject
@property (nonatomic,assign) BOOL isSuccess;
@end

@interface RemotePairLockInfo : NSObject
@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSString *mac;
@property (nonatomic,assign) int status;//1:success 0:fail
@property (nonatomic,assign) int mode;//1:Manual 2:Automatic
@end

@interface RemoteModeSettingsResult : NSObject
@property (nonatomic,assign) int status;//0:fail 1:Manual 2:Automatic
@end

#pragma mark - Envelop Lock
@interface EnvelopLockVerifiedModel: NSObject

@property (nonatomic,assign) UInt8 cmdKey;

@end

@interface EnvelopLockUnlockModel : NSObject

@property (nonatomic,assign) BOOL isSuccess;

@property (nonatomic,strong) NSString *timestamp;

@end

@interface EnvelopLockDetailsModel : NSObject
//0: unlock; 1: lock
@property (nonatomic,assign) int lockStatus;

@property (nonatomic,assign) int electricity;

@property (nonatomic,assign) BOOL haveOldData;

@property (nonatomic,strong) NSString *timestamp;

@end

@interface EnvelopLockLockedModel : NSObject

@property (nonatomic,assign) BOOL isSuccess;

@property (nonatomic,strong) NSString *timestamp;

//mins
@property (nonatomic,assign) int useTime;

@end

@interface EnvelopLockOldDataModel : NSObject

@property (nonatomic,strong) NSString *timestamp;

//mins
@property (nonatomic,assign) int useTime;

//user Id
@property (nonatomic,assign) int userId;

@end

@interface EnvelopLockClearDataModel : NSObject

@property (nonatomic,assign) BOOL isSuccess;

@end

#pragma mark - upgrade
@interface UpgradeVerifyModel : NSObject

//explain
@property (nonatomic,strong) NSString *message;

// Yes: allow;  No: refuse
@property (nonatomic,assign) BOOL isSuccess;

@property (nonatomic,assign) UInt8 cmdKey;

@end

@interface UpgradeCMDModel : NSObject

//explain
@property (nonatomic,strong) NSString *message;

@property (nonatomic,assign) int state;

@end

@interface StartTransferModel : NSObject
//0:Upgrade; 1:DeviceInfo
@property (nonatomic,assign) int type;
//Total number of data packets
@property (nonatomic,assign) int allPages;
//all data's CRC16
@property (nonatomic,assign) int crc16;
//device type
@property (nonatomic,assign) int divType;
//Verification key <4 byte>
@property (nonatomic,strong) NSData *keyData;
@end

@interface ObtainDataModel : NSObject
//current page number
@property (nonatomic,assign) int pageIndex;
//device type
@property (nonatomic,assign) int divType;
@end

@interface  TransferringDataModel: NSObject
//current data's CRC16
@property (nonatomic,assign) int crc16;
//current page number
@property (nonatomic,assign) int pageIndex;
//current data
@property (nonatomic,strong) NSData *data;
@end

@interface DeviceInfoModel : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *blkey;
@property (nonatomic, strong) NSString *uuid;
@property (nonatomic, strong) NSString *major;
@property (nonatomic, strong) NSString *minor;
@property (nonatomic, strong) NSString *rssi;
@property (nonatomic, strong) NSString *rfpower;
@property (nonatomic, strong) NSString *vcode;
@property (nonatomic, strong) NSString *version;
@property (nonatomic, strong) NSString *vdata;
@property (nonatomic, strong) NSString *interva;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *t_start;
@property (nonatomic, strong) NSString *t_stop;
@property (nonatomic, assign) int deviceType;

- (instancetype)initWithDictionary:(NSMutableDictionary *)dic;
@end

#pragma mark - Scooter
@interface ScooterVerifiedModel: NSObject

//explain
@property (nonatomic,strong) NSString *message;

// Yes: allow;  No: refuse
@property (nonatomic,assign) BOOL isSuccess;

@property (nonatomic,assign) UInt8 cmdKey;

@end

@interface ScooterCMDModel : NSObject

//explain
@property (nonatomic,strong) NSString *message;

@property (nonatomic,assign) int state;

@end

@interface ScooterUnlockResultItem : NSObject
@property (nonatomic,strong) NSString *timestamp;
@property (nonatomic,assign) int status;//0:unlocking; 1:success; 2:unlock timeout.

@end

@interface ScooterLockedResultItem : NSObject
@property (nonatomic,strong) NSString *timestamp;
@property (nonatomic,assign) int useTime;
@property (nonatomic,assign) int status;//0:locking; 1:success; 2:lock timeout.
@end


@interface ScooterCheckDetailsItem : NSObject
@property (nonatomic,strong) NSString *voltage;
@property (nonatomic,assign) int lockStatus;//0=open,1=close
@property (nonatomic,assign) BOOL oldData;//N=no old data, Y = have old data
@property (nonatomic,assign) int mVersion;
@property (nonatomic,assign) int lVersion;
@property (nonatomic,assign) int versionCount;//1.0.0 --> mVersion.lVersion.versionCount
@end

@interface ScooterLastDataItem : NSObject
@property (nonatomic,strong) NSString *timestamp;
@property (nonatomic,assign) int useTime;
@property (nonatomic,strong) NSString *uid;
@end


@interface ScooterClearDataItem : NSObject
@property (nonatomic,assign) BOOL isSuccess;

@end

@interface ScooterUseItem : NSObject
@property (nonatomic,strong) NSString *power;
@property (nonatomic,assign) int speedMode;//0:low, 1:middle, 2:high
@property (nonatomic,strong) NSString *speed;//221 --> 22.1km/h
@property (nonatomic,assign) float distance;//10m
@property (nonatomic,assign) float remainDistance;//10m

@end

@interface ScooterSettingsModel : NSObject
@property (nonatomic,assign) BOOL isSuccess;
@property (nonatomic,assign) ScooterSettingsType settingsType;
@end

@interface ScooterExternalDeviceModel : NSObject
@property (nonatomic,assign) ExternalLockDeviceState state;
@property (nonatomic,assign) BOOL isSuccess;
@end

@interface ScooterRfidModel : NSObject
@property (nonatomic,assign) int status;//0:start read card; 1:success
@property (nonatomic,strong) NSString *cardId;//card number
@end

@interface ScooterPowerSettingsModel : NSObject

@property (nonatomic,assign) int status; //0:power off; 1:power on

@end

#pragma mark - bike
@interface BikeLockVerifiedModel: NSObject

@property (nonatomic,assign) UInt8 cmdKey;

@end

@interface BikeLockUnlockModel : NSObject

@property (nonatomic,assign) BOOL isSuccess;

@property (nonatomic,strong) NSString *timestamp;

@end

@interface BikeLockDetailsModel : NSObject
//0: unlock; 1: lock
@property (nonatomic,assign) int lockStatus;

@property (nonatomic,assign) int electricity;

@property (nonatomic,assign) BOOL haveOldData;

@property (nonatomic,strong) NSString *timestamp;

@end

@interface BikeLockLockedModel : NSObject

@property (nonatomic,assign) BOOL isSuccess;

@property (nonatomic,strong) NSString *timestamp;

//mins
@property (nonatomic,assign) int useTime;

@end

@interface BikeLockOldDataModel : NSObject

@property (nonatomic,strong) NSString *timestamp;

//mins
@property (nonatomic,assign) int useTime;

//user Id
@property (nonatomic,assign) int userId;

@end

@interface BikeLockClearDataModel : NSObject

@property (nonatomic,assign) BOOL isSuccess;

@end


NS_ASSUME_NONNULL_END
