//
//  ORTintedView.m
//  Wallpapers
//
//  Created by Orta on 11/3/14.
//  Copyright (c) 2014 Art.sy Inc. All rights reserved.
//

#import "ORTintedView.h"

@implementation ORTintedView

- (void)drawRect:(NSRect)dirtyRect {
    [[NSColor colorWithCalibratedRed:0.162 green:0.137 blue:0.160 alpha:1.000] setFill];
    NSRectFill(dirtyRect);
    [super drawRect:dirtyRect];
}

@end
