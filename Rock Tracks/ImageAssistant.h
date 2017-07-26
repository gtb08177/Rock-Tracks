//
//  ImageAssistant.h
//  Rock Tracks
//
//  Created by Ryan McNulty on 26/07/2017.
//  Copyright © 2017 Ryan McNulty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ImageAssistant : NSObject

+ (void)loadImageUrl:(NSURL *)urlOfImage forUIImageView:(UIImageView *)imageView;

@end
