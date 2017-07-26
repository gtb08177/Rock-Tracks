//
//  Rock_TracksTests.m
//  Rock TracksTests
//
//  Created by Ryan McNulty on 26/07/2017.
//  Copyright © 2017 Ryan McNulty. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TrackItem.h"
#import "Utils.h"

@interface Rock_TracksTests : XCTestCase

@end

@implementation Rock_TracksTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGeneratePriceLabel {
    TrackItem * track = [[TrackItem alloc] init];
    [track setCurrencyIdentifier:@"USD"];
    [track setPrice:1.69];
    
    XCTAssertTrue([@"$1.69" isEqualToString:[Utils generatePriceLabel:track]]);
    
    [track setCurrencyIdentifier:@"GBP"];
    
    XCTAssertFalse([@"$1.69" isEqualToString:[Utils generatePriceLabel:track]]);
    XCTAssertTrue([@"£1.69" isEqualToString:[Utils generatePriceLabel:track]]);

}

- (void)testGenerateDateLabel {
    // 18/07/2016 00:00:00
    NSDate * time1 = [NSDate dateWithTimeIntervalSince1970:1468796400L];
    
    // 19/07/2016 00:00:00
    NSDate * time2 = [NSDate dateWithTimeIntervalSince1970:1468882800L];
    
    TrackItem * track = [[TrackItem alloc] init];
    [track setReleaseDate:time1];
    
    XCTAssertTrue([@"Jul 18, 2016" isEqualToString:[Utils generateDateLabel:track]]);
    
    [track setReleaseDate:time2];
    
    XCTAssertTrue([@"Jul 19, 2016" isEqualToString:[Utils generateDateLabel:track]]);

}

@end
