//
//  Json.h
//  Twitch Stream Status
//
//  Created by Zac Lovoy on 1/15/14.
//  Copyright (c) 2014 Zac Lovoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Json : NSObject

+(NSString*)getStreamStatus:(NSString*)channelName;

@end
