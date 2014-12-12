//
//  NSDictionary+PPJSON.m
//  PubNubTrial
//
//  Created by kaiinui on 2014/12/12.
//  Copyright (c) 2014年 Aquamarine. All rights reserved.
//

#import "NSDictionary+PPJSON.h"

@implementation NSDictionary (PPJSON)

- (NSString *)pp_jsonStringWithPrettyPrint:(BOOL)prettyPrint {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:(NSJSONWritingOptions) (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    
    if (! jsonData) {
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

@end
