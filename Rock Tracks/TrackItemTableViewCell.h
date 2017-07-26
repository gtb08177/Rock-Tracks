//
//  TrackItemTableViewCell.h
//  Rock Tracks
//
//  Created by Ryan McNulty on 26/07/2017.
//  Copyright © 2017 Ryan McNulty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrackItem.h"

@interface TrackItemTableViewCell : UITableViewCell

- (void)digestTrackInfo:(TrackItem *)track;
+ (NSString *)reuseIdentifier;

@end
