//
//  ORRedditSources.h
//  Wallpapers
//
//  Created by orta therox on 18/05/2013.
//  Copyright (c) 2013 Art.sy Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ORAppViewController.h"
#import "ORSimpleSourceListView.h"

@interface ORRedditSources : NSObject <ORSourceListDataSource, ORSourceListDelegate>

@property (unsafe_unretained) IBOutlet ORAppViewController *appViewController;
@property (unsafe_unretained) IBOutlet NSPopUpButton *sourcePopupButton;
@property (unsafe_unretained) IBOutlet ORSimpleSourceListView *sourceView;

- (IBAction)sourceSelectionChanged:(id)sender;

@end
