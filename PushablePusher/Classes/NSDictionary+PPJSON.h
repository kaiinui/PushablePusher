//
//  NSDictionary+PPJSON.h
//  PubNubTrial
//
//  Created by kaiinui on 2014/12/12.
//  Copyright (c) 2014年 Aquamarine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (PPJSON)

/**
 *  @return JSON-Formatted String of the Dictionary.
 */
- (NSString *)pp_jsonStringWithPrettyPrint:(BOOL)prettyPrint;

@end
