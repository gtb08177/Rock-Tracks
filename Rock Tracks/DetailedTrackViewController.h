//
//  DetailedTrackViewController.h
//  Rock Tracks
//
//  Created by Ryan McNulty on 26/07/2017.
//  Copyright © 2017 Ryan McNulty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrackItem.h"

/**
 * View controller for showing details of a given track item
 */
@interface DetailedTrackViewController : UIViewController

- (void)digestTrackItem:(TrackItem *)track;

@end
