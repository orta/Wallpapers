//
//  ORAppViewController.m
//  Wallpapers
//
//  Created by orta therox on 04/02/2013.
//  Copyright (c) 2013 Art.sy Inc. All rights reserved.
//

#import "ORAppViewController.h"
#import "ORRedditImageController.h"
#import "AFImageRequestOperation.h"
#import "ORAppDelegate.h"


@implementation ORAppViewController {
    NSObject<ORGIFSource> *_currentSource;
    NSString *_gifPath;

    ORRedditImageController *_redditController;
    NSString *_currentAddress;

    NSClipView *_imageClipView;
    AFImageRequestOperation *_imageDownloadOperation;
}

- (void)awakeFromNib {
    _redditController = [[ORRedditImageController alloc] init];
    _redditController.gifController = self;
    [_redditController setRedditURL:_currentAddress];
    _currentSource = _redditController;
    [_imageBrowser setValue:[NSColor clearColor] forKey:IKImageBrowserBackgroundColorKey];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(myTableClipBoundsChanged:)
                                                 name:NSViewBoundsDidChangeNotification object:[_imageBrowser superview]];
}

- (void)setRedditAddress:(NSString *)address {
    [_redditController setRedditURL:address];
    _currentAddress = address;
    [_imageBrowser reloadData];
}

- (NSUInteger)numberOfItemsInImageBrowser:(IKImageBrowserView *)aBrowser {
    return _currentSource.numberOfGifs;
}

- (void)gotNewGIFs {
    [_imageBrowser reloadData];
    [self myTableClipBoundsChanged:nil];
}

- (void)myTableClipBoundsChanged:(NSNotification *)notification
{
    NSClipView *clipView = [notification object];
    NSRect newClipBounds = [clipView bounds];
    CGFloat height = [(NSScrollView *)_imageBrowser.superview.superview contentSize].height;
    CGFloat offset = CGRectGetMinY(newClipBounds);
    if (offset == 0 ) return;

    if (offset < height + 20) {
        [_currentSource getNextGIFs];
    }

}

- (void)imageBrowser:(IKImageBrowserView *)aBrowser cellWasRightClickedAtIndex:(NSUInteger)index withEvent:(NSEvent *)event {
    NSMenu *menu = [[NSMenu alloc] initWithTitle:@"menu"];
    [menu setAutoenablesItems:NO];
    NSMenuItem *item = [menu addItemWithTitle:@"Copy URL to Clipboard" action:@selector(copyURL) keyEquivalent:@""];
    [item setTarget:self];
    NSMenuItem *item2 = [menu addItemWithTitle:@"Open discussion on Reddit" action:@selector(openURL) keyEquivalent:@""];
    [item2 setTarget:self];
    [NSMenu popUpContextMenu:menu withEvent:event forView:aBrowser];
}

- (void)copyURL {
    [[NSPasteboard generalPasteboard] clearContents];
    [[NSPasteboard generalPasteboard] writeObjects:@[_currentGIF.downloadURL]];
}

- (void)openURL {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:_currentGIF.source]];
}

- (id)imageBrowser:(IKImageBrowserView *)aBrowser itemAtIndex:(NSUInteger)index {
    return [_currentSource gifAtIndex:index];;
}

- (void)imageBrowserSelectionDidChange:(IKImageBrowserView *)aBrowser {
    NSInteger index = [[aBrowser selectionIndexes] lastIndex];

    if(index != NSNotFound) {
        [ARAnalytics event:@"Selected a wallpaper"];

        Image *gif = [_currentSource gifAtIndex:index];
        _currentGIF = gif;

        [_imageDownloadOperation cancel];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:gif.downloadURL];
        _imageDownloadOperation = [AFImageRequestOperation imageRequestOperationWithRequest:request success:^(NSImage *image) {
            
            _gifPath = [NSTemporaryDirectory() stringByAppendingString: [gif.downloadURL lastPathComponent]];
            if ([[NSFileManager defaultManager] fileExistsAtPath:_gifPath]) {
                [[NSFileManager defaultManager] removeItemAtPath:_gifPath error:nil];
            }
            
            [_imageDownloadOperation.responseData writeToFile:_gifPath atomically:YES];

            [ORAppDelegate setNetworkActivity:NO];

            NSError *error = nil;
            [[NSWorkspace sharedWorkspace] setDesktopImageURL:[NSURL fileURLWithPath:_gifPath] forScreen:[NSScreen mainScreen] options:nil error:&error];
            if (error) {
                NSLog(@"Error %@", error.localizedDescription);
            }

        }];
        [ORAppDelegate setNetworkActivity:YES];
        [_imageDownloadOperation start];
    }
}

- (IBAction)hideOtherAppsTapped:(id)sender {
    [[NSWorkspace sharedWorkspace] hideOtherApplications];
}

- (NSString *)gifFilePath {
    return _gifPath;
}

@end
