//
//  Json.m
//  Twitch Stream Status
//
//  Created by Zac Lovoy on 1/15/14.
//  Copyright (c) 2014 Zac Lovoy. All rights reserved.
//

#import "Json.h"

@implementation Json

// Function to send a JSON command to the server and return the raw data (GET)
+(NSMutableData*)sendJsonCommandToData:(NSMutableString*)cmd{
    NSURL *URL = [NSURL URLWithString:[cmd stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableData *data = [NSData dataWithContentsOfURL:URL];
    return data;
}

// Function to get the UserData for a user given an API key
+(NSString*)getStreamStatus:(NSString*)channelName {
    // Start building the command
    NSMutableString *command = [[NSMutableString alloc] init];
    // Set URL
    [command appendString:@"https://api.twitch.tv/kraken/streams/"];
    // Set Key
    [command appendString:channelName];
    // Run json command
    NSMutableData *resultData = [self sendJsonCommandToData:command];
    
    // Decode result
    NSError *e = nil;
    NSString *status = [[NSString alloc]init];
    @try {
        NSMutableDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error: &e];
        @try {
            status = [jsonArray valueForKey:@"stream"];
        }
        @catch (NSException *e) {
            status = @"ERROR";
        }
    }
    @catch (NSException *e) {
        status = @"ERROR";
    }
    return status;
}

@end
