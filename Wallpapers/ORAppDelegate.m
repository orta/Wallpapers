//
//  ORAppDelegate.m
//  Space Wallpapers
//
//  Created by orta therox on 04/02/2013.
//  Copyright (c) 2013 Art.sy Inc. All rights reserved.
//

#import "ORAppDelegate.h"

@implementation ORAppDelegate

static ORAppDelegate *_sharedInstance = nil;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    _sharedInstance = self;
    _hideWindowButton.delegate = self;
    [ARAnalytics setupMixpanelWithToken:@"d0ac061332bb5978e0b8588c9c0ad78d"];
}

- (void)buttonMouseDown {
    [_window.animator setAlphaValue:0.05];
    [[NSWorkspace sharedWorkspace] hideOtherApplications];
    [ARAnalytics event:@"Made Transparent"];
}

- (void)buttonMouseUp {
    [_window.animator setAlphaValue:1];
}

+ (void)setNetworkActivity:(BOOL)activity {
    if (activity) {
        [_sharedInstance.networkProgress startAnimation:self];
    } else {
        [_sharedInstance.networkProgress stopAnimation:self];
    }
}

@end
