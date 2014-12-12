//
//  PTPusher+PPPushable.m
//  PubNubTrial
//
//  Created by kaiinui on 2014/12/12.
//  Copyright (c) 2014年 Aquamarine. All rights reserved.
//

#import "PTPusher+PPPushable.h"

#import "NSData+PPMD5.h"
#import "NSString+PPHMACSHA256Hex.h"
#import "NSDictionary+PPJSON.h"

#import <AFNetworking.h>
#import <objc/runtime.h>

NSString *const kPPPusherBaseURL = @"https://api.pusherapp.com/";

@interface PTPusher (PPPushableProperties)

@property (nonatomic, copy) NSString *pp_appID;
@property (nonatomic, copy) NSString *pp_accessKey;
@property (nonatomic, copy) NSString *pp_secretKey;

@end

@implementation PTPusher (PPPushableProperties)

# pragma mark - Properties

- (NSString *)pp_appID {
    return objc_getAssociatedObject(self, @selector(pp_appID));
}

- (void)setPp_appID:(NSString *)pp_appID {
    objc_setAssociatedObject(self, @selector(pp_appID), pp_appID, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)pp_accessKey {
    return objc_getAssociatedObject(self, @selector(pp_accessKey));
}

- (void)setPp_accessKey:(NSString *)pp_accessKey {
    objc_setAssociatedObject(self, @selector(pp_accessKey), pp_accessKey, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)pp_secretKey {
    return objc_getAssociatedObject(self, @selector(pp_secretKey));
}

- (void)setPp_secretKey:(NSString *)pp_secretKey {
    objc_setAssociatedObject(self, @selector(pp_secretKey), pp_secretKey, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end

@implementation PTPusher (PPPushable)

- (void)pp_setAppID:(NSString *)appID key:(NSString *)accessKey secretKey:(NSString *)secretKey {
    self.pp_appID = appID;
    self.pp_accessKey = accessKey;
    self.pp_secretKey = secretKey;
}

- (void)pp_triggerEventNamed:(NSString *)event toChannelNamed:(NSString *)channelName data:(id)data {
    if ([self hasCredentialsSet] == NO) {
        NSLog(@"PushablePusher: You should set credentials with `- setAppID:accessKey:secretKey:` at first!");
        return;
    }
    
    [self pp_triggerEventNamed:event toChannelNamed:channelName data:data appID:self.pp_appID accessKey:self.pp_accessKey secretKey:self.pp_secretKey];
}

# pragma mark - Helpers (Property Checking)

- (BOOL)hasCredentialsSet {
    return (self.pp_appID && self.pp_accessKey && self.pp_secretKey);
}

# pragma mark - Protected

- (void)pp_triggerEventNamed:(NSString *)event
           toChannelNamed:(NSString *)channelName
                     data:(id)data appID:(NSString *)appID
                accessKey:(NSString *)accessKey
                secretKey:(NSString *)secretKey {
    // @see http://pusher.com/docs/rest_api#events
    NSDictionary *params = @{
                             @"name": event,
                             @"channel": channelName,
                             @"data": [((NSDictionary *)data) pp_jsonStringWithPrettyPrint:NO]
                             };
    NSString *requestPath = [self pp_requestPathFromAppID:appID accessKey:accessKey params:params timestamp:[self pp_timestamp]];
    NSString *signature = [self pp_signatureFromRequestPath:requestPath secretKey:secretKey];
    NSString *URL = [NSString stringWithFormat:@"%@%@&auth_signature=%@", kPPPusherBaseURL, requestPath, signature];
    
    [[self pp_manager] POST:URL parameters:params success:nil failure:nil];
}

# pragma mark - Helpers (Triggering Event)

- (AFHTTPRequestOperationManager *)pp_manager {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    return manager;
}

// @see http://pusher.com/docs/rest_api#authentication
- (NSString *)pp_requestPathFromAppID:(NSString *)appID accessKey:(NSString *)accessKey params:(NSDictionary *)params timestamp:(NSNumber *)timestamp {
    NSData *requestBody = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:@"http://example.com/" parameters:params error:nil].HTTPBody;
    NSString *md5 = [requestBody pp_md5];
    
    return [NSString stringWithFormat:@"apps/%@/events?auth_key=%@&auth_timestamp=%@&auth_version=%@&body_md5=%@", appID, accessKey, [self pp_timestamp], @"1.0", md5];
}

// @see http://pusher.com/docs/rest_api#authentication
- (NSString *)pp_signatureFromRequestPath:(NSString *)path secretKey:(NSString *)secretKey {
    NSString *stringToSign = [NSString stringWithFormat:@"POST\n/%@", [path stringByReplacingOccurrencesOfString:@"?" withString:@"\n"]];
    return [NSString pp_HMACSHA256HexDigestStringWithKey:secretKey usingData:stringToSign];
}

- (NSNumber *)pp_timestamp {
    return @((int)[[NSDate date] timeIntervalSince1970]);
}

@end
