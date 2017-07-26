//
//  Utils.h
//  Rock Tracks
//
//  Created by Ryan McNulty on 26/07/2017.
//  Copyright © 2017 Ryan McNulty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TrackItem.h"

@interface Utils : NSObject

/**
 * Executes a network request to the given URL
 * and will call either the success or error block
 */
+ (void)queryForJsonResponse:(nonnull NSURL *)queryUrl withSuccessBlock:(void (^_Nonnull)(NSArray<TrackItem *> * _Nonnull validTracksFound))successBlock andErrorBlock:(void (^_Nonnull)(NSError *_Nonnull))errorBlock;

+ (NSString *)generatePriceLabel:(TrackItem *)track;

@end
