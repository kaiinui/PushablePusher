//
//  NSString+PPHMACSHA256Hex.h
//  PubNubTrial
//
//  Created by kaiinui on 2014/12/12.
//  Copyright (c) 2014年 Aquamarine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PPHMACSHA256Hex)

/**
 *  Returns HMAC SHA-256 Hex Digest of given data with signing with given key.
 *
 *  @param key  A Salt to used by signing.
 *  @param data A Data to sign.
 *
 *  @return HMAC SHA-256 Hex Digest
 */
+ (NSString *)pp_HMACSHA256HexDigestStringWithKey:(NSString *)key usingData:(NSString *)data;

@end
