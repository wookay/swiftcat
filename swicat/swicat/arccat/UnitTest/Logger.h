//
//  Logger.h
//  TestApp
//
//  Created by ssukcha on 05/09/13.
//  Copyright (c) 2013 factorcat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSStringExt.h"

#define FILENAME_PADDING 23
#define __FILENAME__ (strrchr(__FILE__,'/')+1)

#define print_log_info(const_chars_fmt, ...) stdout_log_info(0, __FILENAME__, __LINE__, const_chars_fmt, ##__VA_ARGS__)
#define log_info(const_chars_fmt, ...) stdout_log_info(1, __FILENAME__, __LINE__, const_chars_fmt, ##__VA_ARGS__)
void stdout_log_info(BOOL filename_lineno_flag, const char* filename, int lineno, id format, ...) ;
