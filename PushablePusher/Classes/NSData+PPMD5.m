//
//  NSData+PPMD5.m
//  PubNubTrial
//
//  Created by kaiinui on 2014/12/12.
//  Copyright (c) 2014年 Aquamarine. All rights reserved.
//

#import "NSData+PPMD5.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSData (PPMD5)

- (NSString *)pp_md5 {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( self.bytes, self.length, result ); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
