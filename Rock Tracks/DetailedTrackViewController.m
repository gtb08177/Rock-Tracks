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
    [self.releaseDateLabel setText:[self generateDateLabel]];
    [ImageAssistant loadImageUrl:self.thisTrackItem.artworkUrl forUIImageView:self.packshotImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSString *)friendlyDurationLabel {
    NSInteger mins = self.thisTrackItem.duration % 60;
    NSInteger seconds = (self.thisTrackItem.duration / 60) % 60;
    
    return [NSString stringWithFormat:@"%ld:%.02ld",mins,seconds];
}

- (IBAction)launchTrackViewUrl:(id)sender {
    SFSafariViewController * safariViewController = [[SFSafariViewController alloc] initWithURL:self.thisTrackItem.trackViewUrl];
    safariViewController.delegate = self;
    [self presentViewController:safariViewController animated:true completion:nil];
}

/*! @abstract Delegate callback called when the user taps the Done button. Upon this call, the view controller is dismissed modally. */
- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    
}

/*! @abstract Invoked when the initial URL load is complete.
 @param success YES if loading completed successfully, NO if loading failed.
 @discussion This method is invoked when SFSafariViewController completes the loading of the URL that you pass
 to its initializer. It is not invoked for any subsequent page loads in the same SFSafariViewController instance.
 */
- (void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully {
    
}

- (void)digestTrackItem:(TrackItem *)track {
    self.thisTrackItem = track;
}

- (NSString *)generateDateLabel {
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MMM d, yyyy"];
    
    return [df stringFromDate:self.thisTrackItem.releaseDate];
}


@end
