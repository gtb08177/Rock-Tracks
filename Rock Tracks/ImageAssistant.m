//
//  ImageAssistant.m
//  Rock Tracks
//
//  Created by Ryan McNulty on 26/07/2017.
//  Copyright © 2017 Ryan McNulty. All rights reserved.
//

#import "ImageAssistant.h"

@implementation ImageAssistant

+ (void)loadImageUrl:(NSURL *)urlOfImage forUIImageView:(UIImageView *)imageView {
    NSURLRequest * urlRequest = [NSURLRequest requestWithURL:urlOfImage];
    
    NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession * session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error && data)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [imageView setImage:[UIImage imageWithData:data]];
            });
        }
    }];
    
    [dataTask resume];
}

@end
