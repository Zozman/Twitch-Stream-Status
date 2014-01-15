//
//  AppDelegate.h
//  Twitch Stream Status
//
//  Created by Zac Lovoy on 1/15/14.
//  Copyright (c) 2014 Zac Lovoy. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSTextField *channelTextBox;
@property (weak) IBOutlet NSButton *monitorButton;
- (IBAction)monitorButton:(id)sender;
@property (weak) IBOutlet NSProgressIndicator *runningIndicator;
@property (weak) IBOutlet NSLevelIndicator *statusIndicator;


@end
