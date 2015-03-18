//
//  ORRedditSources.m
//  Wallpapers
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
    [_sourceView reloadData];

    NSArray *keys = _sources.allValues;
    NSString *randID = _sources[keys[arc4random_uniform((int)keys.count)]];

    NSString *redditAddress = [NSString stringWithFormat:@"http://www.reddit.com/r/%@.json", randID];
    [_appViewController setRedditAddress:redditAddress];
}

- (NSImage *)sourceList:(ORSimpleSourceListView *)sourceList imageForHeaderInSection:(NSUInteger)section {
    return nil;
}

- (NSString *)sourceList:(ORSimpleSourceListView *)sourceList titleOfHeaderForSection:(NSUInteger)section {
    return @"SOURCES";
}

- (ORSourceListItem *)sourceList:(ORSimpleSourceListView *)sourceList sourceListItemForIndexPath:(NSIndexPath *)indexPath {
    ORSourceListItem *item = [[ORSourceListItem alloc] init];
    item.title = _sources.allKeys[indexPath.row];
    return item;
}

- (NSUInteger)sourceList:(ORSimpleSourceListView *)sourceList numberOfRowsInSection:(NSUInteger)section {
    return _sources.allValues.count;
}

- (NSUInteger)numberOfSectionsInSourceList:(ORSimpleSourceListView *)sourceList {
    return 1;
}

#pragma mark -
#pragma mark ORSourceListDelegate

- (void)sourceList:(ORSimpleSourceListView *)sourceList selectionDidChangeToIndexPath:(NSIndexPath *)indexPath {
    NSUInteger index = indexPath.row;

    NSString *title = _sources.allKeys[index];
    [ARAnalytics event:@"Changed Group" withProperties:@{ @"name": title }];

    NSString *redditAddress = [NSString stringWithFormat:@"http://www.reddit.com/r/%@.json", _sources[title]];
    [_appViewController setRedditAddress:redditAddress];
}

- (void)sourceList:(ORSimpleSourceListView *)sourceList didClickOnRightButtonForIndexPath:(NSIndexPath *)indexPath {}


@end
