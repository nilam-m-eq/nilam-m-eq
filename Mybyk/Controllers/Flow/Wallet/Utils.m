//
//  Utils.m
//  frameworkIntegration
//
//  Created by Honey Lakhani on 1/16/17.
//  Copyright © 2017 com.payu. All rights reserved.
//

#import "Utils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation Utils
- (NSString *)getRandomString:(NSInteger)length
{
  NSMutableString *returnString = [NSMutableString stringWithCapacity:length];
  
  NSString *numbers = @"0123456789";
  
  // First number cannot be 0
  [returnString appendFormat:@"%C", [numbers characterAtIndex:(arc4random() % ([numbers length]-1))+1]];
  
  for (int i = 1; i < length; i++) {
    [returnString appendFormat:@"%C", [numbers characterAtIndex:arc4random() % [numbers length]]];
  }
  
  
  return [NSString stringWithFormat:@"0nf7%@",returnString];
}
//- (NSString *) createSHA512:(NSString *)source {
//  
//  const char *s = [source cStringUsingEncoding:NSASCIIStringEncoding];
//  
//  NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
//  
//  uint8_t digest[CC_SHA512_DIGEST_LENGTH] = {0};
//  
//  CC_SHA512(keyData.bytes, (CC_LONG)keyData.length, digest);
//  
//  NSData *output = [NSData dataWithBytes:digest length:CC_SHA512_DIGEST_LENGTH];
//  NSLog(@"out --------- %@",output);
//  
//  NSString *str = [[[[output description]stringByReplacingOccurrencesOfString:@"<" withString:@""]stringByReplacingOccurrencesOfString:@">" withString:@""]stringByReplacingOccurrencesOfString:@" " withString:@""];
//  return str;
//}

- (NSString*) createSHA512:(NSString *)source {
    
    const char *cstr = [source cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:source.length];
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* output = [NSMutableString  stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];

    for(int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    NSString *hash =  [[[output stringByReplacingOccurrencesOfString:@"<" withString:@""]stringByReplacingOccurrencesOfString:@">" withString:@""]stringByReplacingOccurrencesOfString:@" " withString:@""];

    return hash;
}



@end
