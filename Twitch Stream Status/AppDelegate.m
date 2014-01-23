//
//  AppDelegate.m
//  Twitch Stream Status
//
//  Created by Zac Lovoy on 1/15/14.
//  Copyright (c) 2014 Zac Lovoy. All rights reserved.
//

#import "AppDelegate.h"
#import "Json.h"
#import <AVFoundation/AVFoundation.h>

@implementation AppDelegate {
    AVAudioPlayer* audioPlayer;
}

NSTimer *checker;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSString* path = [[NSBundle mainBundle] pathForResource:@"siren" ofType:@"mp3"];
    NSURL* file = [NSURL fileURLWithPath:path];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:file error:nil];
    [audioPlayer prepareToPlay];
}

- (IBAction)monitorButton:(id)sender {
    if ([_monitorButton state] == NSOnState) {
        [self activateChecker];
    }
    else {
        [self deactivateChecker];
    }
}

-(void)checker{
    NSLog(@"CHECKING...");
    NSString *status = [Json getStreamStatus:[_channelTextBox stringValue]];
    if ([status  isEqual: @"ERROR"]) {
        [_statusIndicator setWarningValue:2];
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"ERROR: Channel Name Invalid"];
        [alert runModal];
        [self deactivateChecker];
        [audioPlayer play];
    } else if (status == (id)[NSNull null]) {
        [_statusIndicator setWarningValue:0];
        [self deactivateChecker];
        [audioPlayer play];
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:@"The Stream Has Gone Down!"];
        [alert runModal];
    } else {
        [_statusIndicator setWarningValue:1];
        [audioPlayer pause];
    }
    [_statusIndicator setNeedsDisplay:YES];
}


-(void)activateChecker{
    [_monitorButton setTitle:@"Stop Monitoring"];
    [_monitorButton setState:1];
    [_channelTextBox setEditable:NO];
    [_runningIndicator startAnimation:self];
    [self checker];
    checker = [NSTimer scheduledTimerWithTimeInterval:2.0
                                               target:self
                                             selector:@selector(checker)
                                             userInfo:nil
                                              repeats:YES];
}

-(void)deactivateChecker{
    [_monitorButton setTitle:@"Start Monitoring"];
    [_monitorButton setState:0];
    [_channelTextBox setEditable:YES];
    [_runningIndicator stopAnimation:self];
    [checker invalidate];
    checker = NULL;
}

@end
