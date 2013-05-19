//
//  ORRedditImageController.h
//  GIFs
//
//  Created by orta therox on 12/01/2013.
//  Copyright (c) 2013 Orta Therox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ORAppViewController.h"

@interface ORRedditImageController : NSObject <ORGIFSource>

- (void)setRedditURL:(NSString *)redditURL;

@property (unsafe_unretained) IBOutlet ORAppViewController *gifController;

@end
