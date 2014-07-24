//
//  Logger.m
//  TestApp
//
//  Created by ssukcha on 05/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import "Logger.h"

void stdout_log_info(BOOL filename_lineno_flag, const char* filename, int lineno, id format, ...) {
#if LOGGER_OFF
    return;
#endif
    
    NSString *str;
    if ([format isKindOfClass:[NSString class]]) {
        va_list args;
        va_start (args, format);
        str = [[NSString alloc] initWithFormat:format  arguments:args];
        va_end (args);
    } else {
        str = [[NSString alloc] initWithString:[format description]];
    }
    BOOL log_print = true;
    if (log_print) {
        NSString* text;
        if (filename_lineno_flag) {
            NSString* printFormat = [NSString stringWithFormat:@"%%%ds #%%03d   %%@\n", FILENAME_PADDING];
            text = [NSString stringWithFormat:printFormat, filename, lineno, str];
        } else {
            text = [NSString stringWithFormat:@"%@", str];
        }
//        if (nil != LOGGERMAN.delegate) {
//            [LOGGERMAN.delegate loggerTextOut:text];
//        }
        printf("%s", [text UTF8String]);
    }
    
//    [str release];
}