//
//  Image.m
//  Wallpapers
//
//  Created by orta therox on 12/01/2013.
//  Copyright (c) 2013 Orta Therox. All rights reserved.
//

#import "Image.h"
#import "NSString+StringBetweenStrings.h"

@implementation Image {
    NSString *_thumbnailURL;
    NSString *_downloadURL;
    NSString * _imageSizeString;
    NSString *_sourceURL;
}

- (id)initWithRedditDictionary:(NSDictionary *)dictionary {
    self = [super init];

    _thumbnailURL = dictionary[@"data"][@"thumbnail"];
    _downloadURL = dictionary[@"data"][@"url"];
    _sourceURL = dictionary[@"data"][@"permalink"];
    
    if (_thumbnailURL.length == 0) {
        if ([_downloadURL rangeOfString:@"imgur"].location != NSNotFound) {
            _thumbnailURL = [_downloadURL stringByReplacingOccurrencesOfString:@".gif" withString:@"b.jpg"];

        } else {
            // ergh, this would take a while
            _thumbnailURL = _downloadURL;
        }
    }

    _downloadURL = [_downloadURL stringByReplacingOccurrencesOfString:@"http://imgur.com/" withString:@"http://imgur.com/download/"];
    if ([_downloadURL rangeOfString:@"imgur"].location == NSNotFound) {
        return nil;
    }

    // get the size out of the brackets
    NSString *unparsedTitle = dictionary[@"data"][@"title"];
    BOOL hasSquare = ([unparsedTitle rangeOfString:@"["].location != NSNotFound);
    BOOL hasCircle = ([unparsedTitle rangeOfString:@"("].location != NSNotFound);

    if (hasSquare || hasCircle) {
        NSString *start = hasSquare? @"[" : @"(";
        NSString *end = hasSquare? @"]" : @")";
        NSString *content = [unparsedTitle substringBetween:start and:end];

        if (content) {
            if ([content rangeOfString:@","].location != NSNotFound) {
                for (NSString *section in [content componentsSeparatedByString:@","]) {
                    if ([section.lowercaseString rangeOfString:@"x"].location != NSNotFound) {
                        content = section;
                    }
                }
            }
            
            NSString *title = [content.lowercaseString stringByReplacingOccurrencesOfString:@"x" withString:@" x "];
            if ([title rangeOfString:@"x"].location != NSNotFound) {
                _imageSizeString = title;
            }
        }
    }

    return self;
}

- (id)initWithDownloadURL:(NSString *)downloadURL andThumbnail:(NSString *)thumbnail {
    self = [super init];

    _thumbnailURL = thumbnail;
    _downloadURL = downloadURL;

    return self;
}

- (NSString *)imageUID {
    return _thumbnailURL;
}

- (NSString *)imageRepresentationType {
    return IKImageBrowserNSURLRepresentationType;
}

- (id) imageRepresentation {
    return [NSURL URLWithString:_thumbnailURL];
}

- (NSURL *)downloadURL {
    return  [NSURL URLWithString:_downloadURL];
}

- (NSString *)imageTitle {
    return _imageSizeString;
}

- (NSString *)source {
    return [NSString stringWithFormat:@"http://reddit.com/%@", _sourceURL];
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:self.class]) {
        return [self.imageUID isEqual:[object imageUID]];
    }
    return  [super isEqual:object];
}

@end
