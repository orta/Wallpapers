//
//  ORRedditImageController.m
//  GIFs
//
//  Created by orta therox on 12/01/2013.
//  Copyright (c) 2013 Orta Therox. All rights reserved.
//

#import "ORRedditImageController.h"
#import "Image.h"
#import "ORAppDelegate.h"
#import <AFNetworking/AFNetworking.h>

@implementation ORRedditImageController {
    NSString *_url;
    NSArray *_gifs;
    NSString *_token;
    AFJSONRequestOperation *_downloadOperation;

    BOOL _downloading;
}

- (void)setRedditURL:(NSString *)redditURL {
    _url = redditURL;
    _gifs = @[];
    _token = nil;
    _downloading = NO;
    [_downloadOperation cancel];
    
    [self getNextGIFs];
}

- (void)getNextGIFs {
    if (_downloading) return;
    
    NSString *address = _url;
    if (_token) {
        address = [address stringByAppendingFormat:@"?after=%@", _token];
    }

    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:address]];

    _downloadOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            [ORAppDelegate setNetworkActivity:NO];
        _token = JSON[@"data"][@"after"];
        NSArray *messages = JSON[@"data"][@"children"];
        NSMutableArray *mutableGifs = [NSMutableArray arrayWithArray:_gifs];

        for (NSDictionary *dictionary in messages) {
            Image *image = [[Image alloc] initWithRedditDictionary:dictionary];
            if (image) {
                [mutableGifs addObject:image];
            }
        }
        _gifs = [NSArray arrayWithArray:mutableGifs];
        _downloading = NO;

        [_gifController gotNewGIFs];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        [ORAppDelegate setNetworkActivity:NO];
        
    }];

    _downloading = YES;
    [_downloadOperation start];
    [ORAppDelegate setNetworkActivity:YES];
}


- (NSUInteger)numberOfGifs {
    return _gifs.count;
}

- (Image *)gifAtIndex:(NSInteger)index {
    return _gifs[index];
}

@end
