//
//  NSDateExt.h
//  TestApp
//
//  Created by ssukcha on 05/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import <Foundation/Foundation.h>

NSDate* DateTime(int year, int month, int day, int hour, int minute, int second) ;
NSDate* NSDateFromString(NSString* str);

typedef enum {
    WEEKDAY_SUNDAY = 1,
    WEEKDAY_MONDAY = 2,
    WEEKDAY_TUESDAY = 3,
    WEEKDAY_WEDNESDAY = 4,
    WEEKDAY_THIRSDAY = 5,
    WEEKDAY_FRIDAY = 6,
    WEEKDAY_SATURDAY = 7
} kWeekdayIndex ;

@interface NSDate (Ext)

+(NSDate*) year:(int)year month:(int)month day:(int)day hour:(int)hour minute:(int)minute second:(int)second ;
-(int) year ;
-(int) month ;
-(int) day ;
-(int) hour ;
-(int) minute ;
-(int) second ;
-(int) weekday ;
-(NSDate*) tomorrow ;
-(NSDate*) yesterday ;

@end


@interface NSDate (CapitalizedExt)
-(NSString*) To_s ;
@end