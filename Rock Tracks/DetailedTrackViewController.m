//
//  DetailedTrackViewController.m
//  Rock Tracks
//
//  Created by Ryan McNulty on 26/07/2017.
//  Copyright © 2017 Ryan McNulty. All rights reserved.
//

#import "DetailedTrackViewController.h"
#import "ImageAssistant.h"

@interface DetailedTrackViewController ()

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
    [self.trackPriceLabel setText:[NSString stringWithFormat:@"£%.02f",self.thisTrackItem.price]];
    [self.durationLabel setText:[NSString stringWithFormat:@"%ld seconds", self.thisTrackItem.duration]];
    [self.releaseDateLabel setText:self.thisTrackItem.releaseDate];
    [ImageAssistant loadImageUrl:self.thisTrackItem.artworkUrl forUIImageView:self.packshotImageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)launchTrackViewUrl:(id)sender {
    [[UIApplication sharedApplication] openURL:self.thisTrackItem.trackViewUrl];
}

- (void)digestTrackItem:(TrackItem *)track {
    self.thisTrackItem = track;
}

@end
