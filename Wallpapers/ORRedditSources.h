//
//  ORRedditSources.h
//  Space Wallpapers
//
//  Created by orta therox on 18/05/2013.
//  Copyright (c) 2013 Art.sy Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ORAppViewController.h"

@interface ORRedditSources : NSObject

@property (unsafe_unretained) IBOutlet ORAppViewController *appViewController;
@property (unsafe_unretained) IBOutlet NSPopUpButton *sourcePopupButton;
- (IBAction)sourceSelectionChanged:(id)sender;

@end
