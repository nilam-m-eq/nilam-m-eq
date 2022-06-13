//
//  BikeLockCmdRespond.h
//  SmartLock
//
//  Created by apple mini on 2021/1/28.
//  Copyright © 2021 Jean. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BikeLockCmdRespond : NSObject

/**
 ! 数据解析
 */
+ (id)initRespondData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
