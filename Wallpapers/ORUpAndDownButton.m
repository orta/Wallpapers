//
//  ORUpAndDownButton.m
//  Wallpapers
//
//  Created by orta therox on 19/05/2013.
//  Copyright (c) 2013 Art.sy Inc. All rights reserved.
//

#import "ORUpAndDownButton.h"

@implementation ORUpAndDownButton

- (void)mouseDown:(NSEvent *)event {
    [_delegate buttonMouseDown];
}

- (void)mouseUp:(NSEvent *)event {
    [_delegate buttonMouseUp];
}


@end
