//
//  TestDate.m
//  TestApp
//
//  Created by WooKyoung Noh on 05/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import "UnitTest.h"
#import "NSDateExt.h"

@interface TestDate : NSObject @end

@implementation TestDate

-(void) test_date {
    NSDate* date = DateTime(2013, 8, 22, 13, 1, 59);
    assert_equal(@"2013-08-22 13:01:59", date.to_s);
    assert_equal(2013, date.year);
    assert_equal(8, date.month);
    assert_equal(22, date.day);
    assert_equal(13, date.hour);
    assert_equal(1, date.minute);
    assert_equal(59, date.second);
    assert_equal(WEEKDAY_THIRSDAY, date.weekday);
    assert_equal(@"2013-08-23 13:01:59", date.tomorrow.to_s);
    assert_equal(WEEKDAY_FRIDAY, date.tomorrow.weekday);
    assert_equal(@"2013-08-21 13:01:59", date.yesterday.to_s);
    assert_equal(WEEKDAY_WEDNESDAY, date.yesterday.weekday);
    assert_equal(date, NSDateFromString(@"2013-08-22 13:01:59"));
}

@end
