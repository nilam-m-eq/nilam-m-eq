//
//  OmniBleManager.h
//  OmniLockDemo
//
//  Created by apple on 2019/12/12.
//  Copyright © 2019 Jean. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "LockEnumObject.h"
#import "LockDetailsItem.h"


NS_ASSUME_NONNULL_BEGIN

@protocol BleManagerDelegate <NSObject>

@optional

/*!
 * @method      scanDevicesResult:
 *
 * @discussion  Invoked when you scan devices. return all nearby devices  {@link scanDevices}
 *
 */
- (void)scanDevicesResult:(NSArray <LockDetailsItem *> *)lists;

/*!
 *  @discussion Invoked when the central manager state is  powered on
 *
 *  @see        bleState
 */
- (void)blePoweredOn;

/*!
 *  @discussion Invoked when the central manager state is powered off
 *
 *  @see        bleState
 */
- (void)blePoweredOff;

/*!
 *  @discussion Invoked when the peripheral connection is failed
 *
 */
- (void)didFailToConnectPeripheral:(CBPeripheral *)peripheral;

/*!
 *  @discussion Invoked when the  peripherals has been disconnected {@link  stop}  {@link cancelLockConnect}
 *
 */
- (void)didDisconnectPeripheral:(CBPeripheral *)peripheral;

/*!
 *  @discussion Invoked when the  peripherals has connected {@link  connectPeripheral:}
 *
 */
- (void)didConnectedPeripheral:(CBPeripheral *)peripheral;

@end

@interface OmniBleManager : NSObject

/*!
 *  @property   lockType
 *
 *  @discussion default is ULock
 *
 */
//@property (nonatomic, assign) LockType lockType;

/*!
 *  @property   bleState
 *
 *  @discussion The current state of the manage
 *
 */
@property(nonatomic, assign, readonly) CBManagerState bleState;

/*!
 *  @property   perState
 *
 *  @discussion The current connection state of the peripheral.
 */
@property(readonly) CBPeripheralState perState;

/*!
 *  @property   delegate
 *
 *  @discussion manager of the current ble  state
 *
 */
@property (nonatomic, weak) id<BleManagerDelegate> delegate;


#pragma mark - method
/*!
 * @method      initBleManager
 *
 * @discussion  The initialization call.  Manager of the different lock, contains ULock, CabinetLock and CableLock.
 */
+ (instancetype)initBleManager;

/*!
 * @method      finish
 *
 * @discussion  remove ble manager and disconnect all peripherals
 *
 */
- (void)finish;

/*!
 * @method      stop
 *
 * @discussion  disconnect all peripherals
 *
 * @see         didDisconnectPeripheral
 */
- (void)stop;

/*!
 * @method      stopScan
 *
 * @discussion  stop scan devices
 */
- (void)stopScan;

/*!
 * @method      cancelBleConnect:
 *
 * @param       idUUIDString      peripheral.identifier.UUIDString
 *
 * @discussion  disconnect peripheral
 *
 * @see         didDisconnectPeripheral
 */
- (void)cancelBleConnect:(NSString *)idUUIDString;

- (void)cancelCurrentConnect;

/*!
 * @method      scanDevices
 *
 * @discussion  Scan for nearby devices. contains ULock, CabinetLock and CableLock.
 *
 * @see         scanDevicesResult:
 */
- (void)scanDevices;

/*!
 * @method      connectPeripheral:
 *
 * @discussion  Connect the target peripheral.  contains ULock, CabinetLock and CableLock.
 *
 * @see         didConnectedPeripheral: withType:
 */
- (void)connectPeripheral:(CBPeripheral *)peripheral;

@end

NS_ASSUME_NONNULL_END
