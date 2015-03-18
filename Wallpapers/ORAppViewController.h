//
//  ORAppViewController.h
//  Wallpapers
//
//  Created by orta therox on 04/02/2013.
//  Copyright (c) 2013 Art.sy Inc. All rights reserved.
//

#import "Image.h"

@protocol ORGIFSource <NSObject>

- (void)getNextGIFs;
- (NSUInteger)numberOfGifs;
- (Image *)gifAtIndex:(NSInteger)index;

@end

@interface ORAppViewController : NSObject
- (void)gotNewGIFs;
- (void)setRedditAddress:(NSString *)address;
@property (unsafe_unretained) IBOutlet IKImageBrowserView *imageBrowser;
@property (unsafe_unretained) IBOutlet NSScrollView *imageScrollView;

@property (strong) Image *currentGIF;
@end
