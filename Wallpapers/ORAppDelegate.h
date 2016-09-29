//
//  ORAppDelegate.h
//  Wallpapers
//
//  Created by orta therox on 04/02/2013.
//  Copyright (c) 2013 Art.sy Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ORUpAndDownButton.h"

@interface ORAppDelegate : NSObject <NSApplicationDelegate, ButtonDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (unsafe_unretained) IBOutlet NSProgressIndicator *networkProgress;
@property (unsafe_unretained) IBOutlet ORUpAndDownButton *hideWindowButton;

+ (void)setNetworkActivity:(BOOL)activity;

@end
