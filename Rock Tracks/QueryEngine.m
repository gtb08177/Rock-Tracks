//
//  QueryEngine.m
//  Rock Tracks
//
//  Created by Ryan McNulty on 26/07/2017.
//  Copyright © 2017 Ryan McNulty. All rights reserved.
//

#import "QueryEngine.h"

@implementation QueryEngine

+ (void)queryForJsonResponse:(nonnull NSURL *)queryUrl withSuccessBlock:(void (^_Nonnull)(NSArray<TrackItem *> * _Nonnull validTracksFound))successBlock andErrorBlock:(void (^_Nonnull)(NSError *_Nonnull))errorBlock {
    
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:queryUrl];

    NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
    //[config setconte]
    NSURLSession * session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            // Something went wrong, pass the error to the error block
            errorBlock(error);
        }
        else
        {
            // Got the data, now try and understand it
            NSError * parsingError;
            NSDictionary * result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&parsingError];
            
            // Parsing error is now defined meaning something went wrong when going from NSData to NSDictionary
            if (parsingError){
                errorBlock(parsingError);
            }
            else {
                // Happy path
                successBlock([QueryEngine convertValidJSONtoTrackItems:result]);
            }
        }
    }];
    
    [dataTask resume];
}

+ (NSArray<TrackItem *> *)convertValidJSONtoTrackItems:(NSDictionary *)jsonResponse {
    NSMutableArray<TrackItem *> * resultArray = [[NSMutableArray alloc] init];
    
    NSArray * allTracks = [QueryEngine getJSONSafeArray:jsonResponse[@"results"]];
    
    for (NSDictionary * possibleTrack in allTracks){
        TrackItem * newTrack = [[TrackItem alloc] init];
        [newTrack setArtist:possibleTrack[@"artistName"]];
        [newTrack setPrice:[possibleTrack[@"trackPrice"] doubleValue]];
        [newTrack setTrackName:possibleTrack[@"trackName"]];
        [newTrack setArtworkUrl:[NSURL URLWithString:possibleTrack[@"artworkUrl100"]]];
        [newTrack setTrackViewUrl:[NSURL URLWithString:possibleTrack[@"trackViewUrl"]]];
        [newTrack setReleaseDate:possibleTrack[@"releaseDate"]];
        [newTrack setDuration:[possibleTrack[@"trackTimeMillis"] longValue] * 0.001];
        
        [resultArray addObject:newTrack];
    }
    
    return [resultArray copy]; // copy makes it immutable
}

/**
 * Given an object, this function will safely put this into an array.
 * If already an array, it is simply returned, if nil, empty array will be given
 */
+ (NSArray *)getJSONSafeArray:(NSObject *)object {
    if ( object == nil ){
        return @[];
    }
    else if ( ![object isKindOfClass:[NSArray class]] ) {
        return @[object];
    }
    
    return (NSArray *) object;
}

@end
