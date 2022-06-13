//
//  BikeLockClient.h
//  SmartLock
//
//  Created by apple mini on 2021/1/28.
//  Copyright © 2021 Jean. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <OmniBaseTool/LockDetailsItem.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BikeLockCmdDelegate <NSObject>

@required
- (void)passBikeCertification;

@optional
- (void)bikeUnlockCompletion:(BikeLockUnlockModel *)completion;

- (void)bikeLockedCompletion:(BikeLockLockedModel *)completion;

- (void)bikeLockDetailsCompletion:(BikeLockDetailsModel *)completion;

- (void)bikeLockLastUsageData:(BikeLockOldDataModel *)completion;

- (void)clearBikeLockLastData:(BikeLockClearDataModel *)completion;

@end

@interface BikeLockClient : NSObject

@property (nonatomic,weak) id <BikeLockCmdDelegate> delegate;

/*!
 * @method      discoverServicesWithPeripheral:
 *
 * @param       peripheral  connect device
 * @param       deviceKey      length = 8
 *
 * @discussion  Find peripheral services  {@link certificationStatus:}
 */
- (void)discoverServicesWithPeripheral:(CBPeripheral *)peripheral withKey:(NSString *)deviceKey;

/*!
 * @method      obtainLockDetails
 *
 * @discussion  Read lock information
 */
- (void)obtainLockDetails;

/*!
 * @method      sendUnlockWithUserId: withTimeStamp:outArea:
 *
 * @param       userId            user id, used to distinguish users
 * @param       timestamp     unlock  timestamp
 * @param       outArea         YES: continue the last unlock record to start timing; NO: start timing from 0 . If it's not required, please set to NO
 *
 * @discussion  Send unlock command
 */
- (void)sendUnlockWithUserId:(int)userId timestamp:(int)timestamp outArea:(BOOL)outArea;

/*!
 * @method      obtainLastUseData
 *
 * @discussion  Get the last recent usage data
 */
- (void)obtainLastUseData;

/*!
 * @method      clearLastData
 *
 * @discussion  Clear the last usage data
 */
- (void)clearLastData;

@end

NS_ASSUME_NONNULL_END
