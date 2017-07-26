//
//  TrackItemTableViewCell.m
//  Rock Tracks
//
//  Created by Ryan McNulty on 26/07/2017.
//  Copyright © 2017 Ryan McNulty. All rights reserved.
//

#import "TrackItemTableViewCell.h"
#import "ImageAssistant.h"

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
    
    
    [self.priceLabel setText:[self generatePriceLabel:track]];

    [ImageAssistant loadImageUrl:track.artworkUrl forUIImageView:self.packshotImageView];
}

+ (NSString *)reuseIdentifier {
    return @"trackItemTableId";
}

- (NSString *)reuseIdentifier {
    return [TrackItemTableViewCell reuseIdentifier];
}

- (NSString *)generatePriceLabel:(TrackItem *)track {
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:track.currencyIdentifier];
    return [NSString stringWithFormat:@"%@%.02f",[locale displayNameForKey:NSLocaleCurrencySymbol value:track.currencyIdentifier], track.price];
}

@end
