//
//  ListViewController.m
//  Rock Tracks
//
//  Created by Ryan McNulty on 26/07/2017.
//  Copyright © 2017 Ryan McNulty. All rights reserved.
//

#import "ViewController.h"
#import "QueryEngine.h"
#import "TrackItem.h"

@interface ListViewController ()

@property NSArray<TrackItem *> * tracks;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tracks = [[NSArray alloc] init];
    // Initialise in the event of an error, the view controller
    // can still look as it should.
    NSURL * endpoint = [NSURL URLWithString:@"https://itunes.apple.com/search?term=rock&media=music"];
    [QueryEngine queryForJsonResponse:endpoint withSuccessBlock:^(NSArray<TrackItem *> * _Nonnull validTracksFound) {
        
    } andErrorBlock:^(NSError * _Nonnull error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void (^)(NSArray<TrackItem *> * _Nonnull validTracksFound))defaultSuccessBlock {
    return ^(NSArray<TrackItem *> * _Nonnull validTracksFound) {
        
    };
}

+ (void (^)(NSError * _Nonnull))defaultErrorBlock {
    return ^(NSError * _Nonnull error) {
        UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"Error" message:[error localizedDescription] preferredStyle:UIAlertControllerStyleAlert];
    };
}

@end
