//
//  PTPusher+PPPushable.h
//  PubNubTrial
//
//  Created by kaiinui on 2014/12/12.
//  Copyright (c) 2014年 Aquamarine. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <PTPusher.h>

/**
 *  PTPusher+PPPushable provides a feature to push a event to a public channel from a client.
 *
 *  @warning This is for debugging / development purpose. DO NOT USE THIS CODE IN PRODUCTION.
 */
@interface PTPusher (PPPushable)

/**
 *  Setup the client for PushablePusher with credentials.
 *
 *  You should setup the client before triggering an event.
 *
 *  @param appID     An App ID such as `78233`
 *  @param accessKey An Access Key such as `bab43fbaaf6b17d91783`
 *  @param secretKey A Secret Key such as `ab89c276b8a974e8a58f`
 */
- (void)pp_setAppID:(NSString *)appID
                key:(NSString *)accessKey
          secretKey:(NSString *)secretKey;

/**
 *  Trigger an event to a channel specified by given name with given data.
 *
 *  @warning You should setup the pusher client with `- setAppID:accessKey:secretKey:` before call the method!
 *
 *  @param event       An event name to trigger.
 *  @param channelName A channel name to trigger the event.
 *  @param data        A data to append.
 */
- (void)pp_triggerEventNamed:(NSString *)event
              toChannelNamed:(NSString *)channelName
                        data:(id)data;

@end
