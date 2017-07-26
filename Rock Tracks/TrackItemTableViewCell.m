//
//  TrackItemTableViewCell.m
//  Rock Tracks
//
//  Created by Ryan McNulty on 26/07/2017.
//  Copyright © 2017 Ryan McNulty. All rights reserved.
//

#import "TrackItemTableViewCell.h"

@interface TrackItemTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *trackNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UIImageView *packshotImageView;

@end

@implementation TrackItemTableViewCell

- (void)digestTrackInfo:(TrackItem *)track {
    
    [self.trackNameLabel setText:track.trackName];
    [self.artistLabel setText:track.artist];
    [self.priceLabel setText:[NSString stringWithFormat:@"£%.02f",track.price]];

    //todo packshot loading
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:track.artworkUrl];
    
    NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error && data)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.packshotImageView setImage:[UIImage imageWithData:data]];
            });
        }
    }];
    
    [dataTask resume];
}

+ (NSString *)reuseIdentifier {
    return @"trackItemTableId";
}

- (NSString *)reuseIdentifier {
    return [TrackItemTableViewCell reuseIdentifier];
}

@end
