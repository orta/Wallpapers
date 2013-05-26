//
//  ORRedditSources.m
//  Space Wallpapers
//
//  Created by orta therox on 18/05/2013.
//  Copyright (c) 2013 Art.sy Inc. All rights reserved.
//

#import "ORRedditSources.h"

@implementation ORRedditSources {
    NSDictionary *_sources;
}

- (void)awakeFromNib {
    _sources =
    @{
      @"Wallpapers": @"wallpapers",
      @"Wallpaper": @"wallpaper",
      @"NSFW (18+)": @"NSFW_Wallpapers",
      @"No Context": @"nocontext_wallpapers",
      @"Minimal": @"MinimalWallpaper",
      @"Minimal Art": @"minimalist_art",
      @"Street Art": @"StreetArtPorn",
      @"Space": @"spaceporn",
      @"Rides": @"RidesPorn",
      @"HD Wallpapers": @"bigwallpapers",
      @"Design": @"DesignPorn",
      @"Fire": @"FirePorn",
      @"Earth": @"EarthPorn",
      @"Cities": @"CityPorn",
      @"Anime": @"animewallpaper",
      @"Animals": @"AnimalPorn",
      @"Abandoned": @"AbandonedPorn"
    };

    [_sourcePopupButton removeAllItems];
    [_sourcePopupButton addItemsWithTitles:_sources.allKeys];
    [self sourceSelectionChanged:nil];
}

- (IBAction)sourceSelectionChanged:(id)sender {
    NSMenuItem *item = _sourcePopupButton.selectedItem;
    NSString *title = item.title;
    NSString *redditAddress = [NSString stringWithFormat:@"http://www.reddit.com/r/%@.json", _sources[title]];
    [_appViewController setRedditAddress:redditAddress];
}
@end
