//
//  ORUpAndDownButton.h
//  Space Wallpapers
//
//  Created by orta therox on 19/05/2013.
//  Copyright (c) 2013 Art.sy Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol ButtonDelegate <NSObject>
- (void)buttonMouseDown;
- (void)buttonMouseUp;
@end

@interface ORUpAndDownButton : NSButton
@property (unsafe_unretained) id <ButtonDelegate> delegate;
@end
