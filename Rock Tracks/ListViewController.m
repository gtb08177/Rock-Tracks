//
//  ListViewController.m
//  Rock Tracks
//
//  Created by Ryan McNulty on 26/07/2017.
//  Copyright © 2017 Ryan McNulty. All rights reserved.
//

#import "ListViewController.h"
#import "QueryEngine.h"
#import "TrackItem.h"
#import "TrackItemTableViewCell.h"

@interface ListViewController ()

@property NSArray<TrackItem *> * tracks;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    
    self.tracks = [[NSArray alloc] init];
    // Initialise in the event of an error, the view controller
    // can still look as it should.
    NSURL * endpoint = [NSURL URLWithString:@"https://itunes.apple.com/search?term=rock&media=music"];
    [QueryEngine queryForJsonResponse:endpoint withSuccessBlock:[self defaultSuccessBlock] andErrorBlock:[self defaultErrorBlock]];
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Rock Tracks";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tracks count];
}

@end
