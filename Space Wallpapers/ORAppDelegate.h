//
//  ORAppDelegate.h
//  Space Wallpapers
//
//  Created by orta therox on 04/02/2013.
//  Copyright (c) 2013 Art.sy Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ORAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (unsafe_unretained) IBOutlet NSProgressIndicator *networkProgress;

+ (void)setNetworkActivity:(BOOL)activity;

@end
