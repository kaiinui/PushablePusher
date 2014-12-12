//
//  NSData+PPMD5.h
//  PubNubTrial
//
//  Created by kaiinui on 2014/12/12.
//  Copyright (c) 2014年 Aquamarine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (PPMD5)

/**
 *  @return MD5 hash of the Data.
 */
- (NSString *)pp_md5;

@end
