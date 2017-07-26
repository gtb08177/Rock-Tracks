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
    [self.priceLabel setText:[NSString stringWithFormat:@"£%f",track.price]];

    //todo packshot loading
}

+ (NSString *)reuseIdentifier {
    return @"trackItemTableId";
}

- (NSString *)reuseIdentifier {
    return [TrackItemTableViewCell reuseIdentifier];
}

@end
