//
//  DetailedTrackViewController.m
//  Rock Tracks
//
//  Created by Ryan McNulty on 26/07/2017.
//  Copyright © 2017 Ryan McNulty. All rights reserved.
//

#import "DetailedTrackViewController.h"
#import "ImageAssistant.h"
#import <SafariServices/SafariServices.h>
#import "Utils.h"

@interface DetailedTrackViewController () <SFSafariViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *packshotImageView;
@property (weak, nonatomic) IBOutlet UILabel *trackName;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *trackPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseDateLabel;

@property TrackItem * thisTrackItem;

@end

@implementation DetailedTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.trackName setText:self.thisTrackItem.trackName];
    [self.artistLabel setText:self.thisTrackItem.artist];
    [self.trackPriceLabel setText:[Utils generatePriceLabel:self.thisTrackItem]];
    [self.durationLabel setText:[self friendlyDurationLabel]];
    [self.releaseDateLabel setText:[Utils generateDateLabel:self.thisTrackItem]];
    [ImageAssistant loadImageUrl:self.thisTrackItem.artworkUrl forUIImageView:self.packshotImageView];
}

/**
 * Returns a min:sec string form
 */
- (NSString *)friendlyDurationLabel {
    NSInteger mins = self.thisTrackItem.duration % 60;
    NSInteger seconds = (self.thisTrackItem.duration / 60) % 60;
    
    return [NSString stringWithFormat:@"%ld:%.02ld",mins,seconds];
}

- (IBAction)launchTrackViewUrl:(id)sender {
    [[UIApplication sharedApplication] openURL:self.thisTrackItem.trackViewUrl];
}

- (void)digestTrackItem:(TrackItem *)track {
    self.thisTrackItem = track;
}

@end
