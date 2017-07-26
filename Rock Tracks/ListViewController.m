//
//  ListViewController.m
//  Rock Tracks
//
//  Created by Ryan McNulty on 26/07/2017.
//  Copyright © 2017 Ryan McNulty. All rights reserved.
//

#import "ListViewController.h"
#import "Utils.h"
#import "TrackItem.h"
#import "TrackItemTableViewCell.h"
#import "DetailedTrackViewController.h"

@interface ListViewController ()

@property NSArray<TrackItem *> * tracks;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Rock Tracks";
    
    [self.tableView setEstimatedRowHeight:140];
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    
    self.tracks = [[NSArray alloc] init];
    // Initialise in the event of an error, the view controller
    // can still look as it should.
    NSURL * endpoint = [NSURL URLWithString:@"https://itunes.apple.com/search?term=rock&media=music"];
    [Utils queryForJsonResponse:endpoint withSuccessBlock:[self defaultSuccessBlock] andErrorBlock:[self defaultErrorBlock]];
}

- (void (^)(NSArray<TrackItem *> * _Nonnull validTracksFound))defaultSuccessBlock {
    return ^(NSArray<TrackItem *> * _Nonnull validTracksFound) {
        self.tracks = validTracksFound;
        [self.tableView reloadData];
    };
}

- (void (^)(NSError * _Nonnull))defaultErrorBlock {
    return ^(NSError * _Nonnull error) {
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"Error" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * okAction = [UIAlertAction actionWithTitle:@"Ok - thanks." style:UIAlertActionStyleDefault handler:nil];
        [alertVC addAction:okAction];
        [self.navigationController presentViewController:alertVC animated:YES completion:nil];
    };
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TrackItemTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[TrackItemTableViewCell reuseIdentifier] forIndexPath:indexPath];
    [cell digestTrackInfo:self.tracks[indexPath.row]];
    return cell;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tracks count];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TrackItem * toServe = self.tracks[[self.tableView indexPathForSelectedRow].row];
    
    DetailedTrackViewController * dest = (DetailedTrackViewController *) [segue destinationViewController];
    [dest digestTrackItem:toServe];
}

@end
